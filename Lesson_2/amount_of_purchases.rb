puts "Сумма покупок"
puts

big_hash = Hash.new
small_hash = Hash.new
array_amount = Array.new
arr_total = Array.new

loop do

print "Введите цену товара за единицу."
price = gets.chomp
print "Введите колличество товара."
quantity = gets.chomp
print "Введите название товара или 'стоп' если товаров нет."
goods = gets.chomp

break if goods == "стоп"

total_price_quantity = price.to_i * quantity.to_i
arr_total << total_price_quantity

goods_amount = "Сумма за #{goods} равна #{total_price_quantity}"
array_amount << goods_amount

small_hash[price] = quantity
small_hash.each { |var| big_hash[goods] = [var].to_h }

end

puts
puts big_hash
puts array_amount
puts "Общая стоимость товаров #{arr_total.sum}"
