i.int = 0
f.int[1000000] =
c.int = 0
m.int = 0
p.int = 0
loops(20):
  for i in range(1000000):
    f[i] = 0
  for i in range(1000):
    if i > 1:
      if f[i] is 0:
        m = (1000000 - i * i) / i + 1
        p = i * i
        loops(m):
          f[p] = 1
          p = p + i
  for i in range(1000000):
    if i > 1:
      if f[i] is 0:
        c = c + 1
print>>c
