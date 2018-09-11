print "Здравствуйте, хотите узнать свой идеальный вес?"
input = gets
var_1 = input.chomp
if
  var_1 == "да" || var_1 == "yes" || var_1 == "lf"
  print "Как Вас зовут? "
  input = gets
  name = input.chomp.capitalize
  print "Какой Ваш рост? "
  input = gets
  height = input.chomp
  while height.to_i == 0
    print "Введите цифры."
    input = gets
    height = input.chomp
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
input = gets
