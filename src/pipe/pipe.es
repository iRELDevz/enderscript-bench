n.int = input
x.int = 0
s.int = 0
loops(n):
  x = input
  s = (s + x) % 1000003
  print>>x * 2 + 1
print>>s
