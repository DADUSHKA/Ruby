arr = []
for i in 10..100
  next if i % 5 != 0
arr << i
end
p arr


array = (10..100).to_a
array.delete_if { |x| x % 5 != 0 }
p array


arr = []
i = 105
loop do
  i -= 1
  next if i % 5 != 0
  break if i <= 5
  arr << i
end
p arr.reverse
