print "Здравствуйте, хотите узнать свой идеальный вес?"
var_1 = gets.chomp

if
  var_1 == "да" || var_1 == "yes" || var_1 == "lf"
  print "Как Вас зовут? "
  name = gets.chomp.capitalize
  print "Какой Ваш рост? "
  height = gets.chomp

  while height.to_i == 0
    print "Введите цифры."
    height = gets.chomp
  end

  final = height.to_i - 110

  if
    final < 0
    puts "#{name} ваш вес идеальный."
  else
    puts "#{name} ваш идеальный вес #{final}."
  end

else
  puts "Досвидания."
end

puts ""
print "Нажмите 'Enter' для выхода из программы."
gets
