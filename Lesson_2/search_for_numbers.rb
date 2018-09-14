puts "Введите дату в формате гггг.мм.дд"
puts

print "Введите год  -"
year = gets.chomp.to_i
print "Введите месяц  -"
month = gets.chomp.to_i
print "Введите день  -"
day = gets.chomp.to_i

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year % 4 == 0
   days_in_month = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
end

day_in_year = days_in_month.first(month-1).sum

puts "Порядковый номер даты - #{day_in_year + day}"
