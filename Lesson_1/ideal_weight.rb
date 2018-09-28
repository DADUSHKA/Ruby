print "Здравствуйте, хотите узнать свой идеальный вес?"
var = gets.chomp

if  var == "да" || var == "yes" || var == "lf"
  print "Как Вас зовут? "
  name = gets.chomp.capitalize
  print "Какой Ваш рост? "
  height = gets.chomp

  while height.to_i == 0
  print "Введите цифры."
    height = gets.chomp
  end

  ideal_weight = height.to_i - 110

if ideal_weight < 0
  puts "#{name} ваш вес идеальный."
else
    puts "#{name} ваш идеальный вес #{ideal_weight}."
end

else
  puts "Досвидания."
end

puts
print "Нажмите 'Enter' для выхода из программы."
gets
