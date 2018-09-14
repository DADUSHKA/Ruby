#{goods: {price: quantity}, goods: {price: quantity}}


puts "Сумма покупок"
puts

big_hash = Hash.new
small_hash = Hash.new

loop do

print "Введите цену товара за единицу."
price = gets.chomp
print "Введите колличество товара."
quantity = gets.chomp
print "Введите название товара."
goods = gets.chomp

break if goods == "стоп"


small_hash[price] = quantity
big_hash[goods] = small_hash

end

puts big_hash
# p goods_amount
# p total_amount
