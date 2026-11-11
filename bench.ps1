param(
    [ValidateSet('x86', 'x64', 'arm64')]
    [string]$Arch = 'x64',
    [string]$Ender = '',
    [int]$Runs = 5,
    [string]$Bench = 'hello,lcg,fizz,modchain,sieve,print,pipe',
    [string]$Lang = 'es,c,cpp,rs,zig,py'
)
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

if ($Ender -eq '') { $Ender = Join-Path $PSScriptRoot 'ender.exe' }
$Ender = (Resolve-Path -LiteralPath $Ender).Path
$target = @{ x86 = 'x86-windows-gnu'; x64 = 'x86_64-windows-gnu'; arm64 = 'aarch64-windows-gnu' }[$Arch]
$ztarget = @{ x86 = 'x86-windows'; x64 = 'x86_64-windows'; arm64 = 'aarch64-windows' }[$Arch]
$rtarget = @{ x86 = 'i686-pc-windows-gnu'; x64 = 'x86_64-pc-windows-gnu'; arm64 = 'aarch64-pc-windows-msvc' }[$Arch]
$work = Join-Path $PSScriptRoot ('work-' + $Arch)
New-Item -ItemType Directory -Force -Path $work | Out-Null

$pipeIn = Join-Path $work 'pipe_in.txt'
if (-not (Test-Path -LiteralPath $pipeIn)) {
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.Append("1000000`n")
    for ($k = 1; $k -le 1000000; $k++) { [void]$sb.Append((($k * 7919) % 1000000).ToString() + "`n") }
    [IO.File]::WriteAllText($pipeIn, $sb.ToString())
}

function Invoke-Exe([string]$Exe, [string[]]$ArgList, [string]$InPath, [string]$Dir = '') {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $Exe
    if ($Dir -ne '') { $psi.WorkingDirectory = $Dir }
    $psi.Arguments = ($ArgList -join ' ')
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardInput = $true
    $psi.CreateNoWindow = $true
    $sw = [Diagnostics.Stopwatch]::StartNew()
    $p = [Diagnostics.Process]::Start($psi)
    $outTask = $p.StandardOutput.ReadToEndAsync()
    if ($InPath) {
        $fs = [IO.File]::OpenRead($InPath)
        $fs.CopyTo($p.StandardInput.BaseStream)
        $fs.Dispose()
    }
    $p.StandardInput.Close()
    $p.WaitForExit()
    $sw.Stop()
    $out = $outTask.Result.Replace("`r`n", "`n")
    return @{ Ms = $sw.Elapsed.TotalMilliseconds; Out = $out; Code = $p.ExitCode }
}

function Build([string]$B, [string]$L) {
    $src = Join-Path (Join-Path (Join-Path $PSScriptRoot 'src') $B) ($B + '.' + $L)
    $dir = Join-Path $work ($B + '-' + $L)
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    $exe = Join-Path $dir ($B + '.exe')
    if ($L -eq 'py') { return @{ Exe = (Get-Command python).Source; Args = @('"' + $src + '"') } }
    if ($L -eq 'es') {
        Copy-Item -LiteralPath $src -Destination $dir -Force
        $null = Invoke-Exe $Ender @($B + '.es') $null $dir
        return @{ Exe = (Join-Path (Join-Path $dir '.ender') ($B + '.exe')); Args = @() }
    }
    if ($L -eq 'c') { & zig cc -target $target -O2 -s -o $exe $src 2>&1 | Out-Null }
    if ($L -eq 'cpp') { & zig c++ -target $target -O2 -s -o $exe $src 2>&1 | Out-Null }
    if ($L -eq 'zig') { & zig build-exe -target $ztarget -O ReleaseFast -fstrip ('-femit-bin=' + $exe) $src 2>&1 | Out-Null }
    if ($L -eq 'rs') { & rustc --target $rtarget -C opt-level=3 -C strip=symbols -o $exe $src 2>&1 | Out-Null }
    return @{ Exe = $exe; Args = @() }
}

$rows = @()
foreach ($b in $Bench.Split(',')) {
    $ref = $null
    $line = $b.PadRight(9)
    foreach ($l in $Lang.Split(',')) {
        try { $t = Build $b $l } catch { $line += (' ' + $l + ' build-fail'); continue }
        if (-not (Test-Path -LiteralPath $t.Exe)) { $line += (' ' + $l + ' build-fail'); continue }
        $in = $null
        if ($b -eq 'pipe') { $in = $pipeIn }
        $n = $Runs
        if ($l -eq 'py' -and $b -in @('lcg', 'fizz', 'modchain', 'sieve')) { $n = 1 }
        $best = [double]::MaxValue
        $out = ''
        for ($i = 0; $i -lt $n; $i++) {
            $r = Invoke-Exe $t.Exe $t.Args $in
            if ($r.Ms -lt $best) { $best = $r.Ms }
            $out = $r.Out
        }
        if ($null -eq $ref) { $ref = $out }
        $same = ''
        if ($out -ne $ref) { $same = '!' }
        $line += (' ' + $l + ' ' + [math]::Round($best, 1).ToString() + $same)
        $rows += [pscustomobject]@{ bench = $b; lang = $l; ms = [math]::Round($best, 1); same = ($out -eq $ref) }
    }
    Write-Output $line
}
$rows | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $PSScriptRoot ('results-' + $Arch + '.json')) -Encoding ascii
$bad = @($rows | Where-Object { -not $_.same })
if ($bad.Count -gt 0) { Write-Output 'DIFFERENT OUTPUT'; exit 1 }
exit 0
