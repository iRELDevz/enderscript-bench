s.int = 0
t.int = 1
for i in range(100000000):
  s = (s * 7 + i) % 1000003
  t = (t + s / 7 + 3) % 65521
print>>{s}" "{t}
