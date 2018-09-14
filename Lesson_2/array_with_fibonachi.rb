arr = Array.new
a = 0
b = 1

while b < 100
  arr << b
  a, b = b, a + b
end

p arr


