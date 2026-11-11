a.int = 0
b.int = 0
for i in range(200000000):
  if i % 15 is 0:
    a = a + 1
  elif i % 3 is 0:
    b = (b + i) % 1000003
  elif i % 5 is 0:
    b = (b + 7) % 1000003
print>>{a}" "{b}
