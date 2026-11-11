# enderscript-bench

source sama cara jalanin bench yang dipake di README [EnderScript](https://github.com/iRELDevz/enderscript). tujuannya biar angkanya bisa dicek sendiri sama siapa aja.

## isi

- `src/<bench>/`: program yang sama ditulis di EnderScript, C, C++, Rust, Zig, sama Python. algoritmanya sama, tipe datanya int32, dan outputnya harus sama persis byte per byte.
- `bench.ps1`: build semua program terus ngukur waktunya.
- `tests/`: test suite compiler EnderScript, dipake di CI arm64.
- `.github/workflows/arm64.yml`: build compiler arm64 dari repo utama, ngetes di runner `windows-11-arm`, terus ngebench.

## bench

| bench | isinya |
|---|---|
| hello | nyetak satu baris |
| lcg | 200 juta iterasi `x = x * 1103515245 + 12345` plus cek `x < 0 or x % 7 is 0` |
| fizz | 200 juta iterasi fizzbuzz yang diitung pake modulo |
| modchain | 100 juta iterasi rantai `*`, `/`, `%` |
| sieve | sieve of eratosthenes sampe 1 juta, diulang 20 kali |
| print | nyetak angka 1 sampe 1 juta |
| pipe | baca 1 juta angka dari stdin, olah, terus cetak lagi |

## compiler sama flag

| bahasa | compiler | flag |
|---|---|---|
| EnderScript | `ender.exe` | default |
| C | clang (`zig cc`) | `-O2 -s` |
| C++ | clang++ (`zig c++`) | `-O2 -s` |
| Rust | `rustc` | `-C opt-level=3 -C strip=symbols` |
| Zig | `zig build-exe` | `-O ReleaseFast -fstrip` |
| Python | CPython 3.12 | - |

C sama C++ sengaja pake clang dari zig biar compilernya sama di x86, x64, sama arm64.

angka yang dilaporin itu waktu paling cepet dari beberapa kali jalan (default 5, python di bench berat cuma 1 kali). waktunya diukur dari luar, jadi udah termasuk start proses.

## cara jalanin

butuh: zig, rustc, python, sama `ender.exe`.

```
.\bench.ps1 -Arch x64 -Ender C:\path\ke\ender.exe
.\bench.ps1 -Arch x86 -Ender C:\path\ke\ender.exe -Bench lcg,sieve -Lang es,c,zig
```

hasilnya keluar di layar sama di `results-<arch>.json`. kalo ada bahasa yang outputnya beda, scriptnya keluar dengan exit 1.

## lisensi

Apache License 2.0, sama kayak EnderScript.
