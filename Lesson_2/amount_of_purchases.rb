puts "Сумма покупок"
puts

goods_hash = {}
price_quantity_hash = {}
amount_hash = {}
arr_total_price = []

loop do

print "Введите цену товара за единицу."
price = gets.chomp.to_i
print "Введите колличество товара."
quantity = gets.chomp.to_i
print "Введите название товара или 'стоп' если товаров нет."
goods = gets.chomp

break if goods == "стоп"

amount_hash[goods] = { price: price, quantity: quantity }

total_price_quantity = amount_hash[goods][:price] * amount_hash[goods][:quantity]
arr_total_price << total_price_quantity


end

puts amount_hash

amount_hash.each { |key, value|
 puts "Сумма за #{ key } равна #{ amount_hash[key][:price] * amount_hash[key][:quantity] } " }

puts "Общая стоимость товаров #{ arr_total_price.sum }"
