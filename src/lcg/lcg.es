x.int = 1
n.int = 0
for k in range(200000000):
  x = x * 1103515245 + 12345
  if x < 0 or x % 7 is 0:
    n = n + 3
print>>{n}" "{x}
