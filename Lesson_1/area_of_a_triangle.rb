puts "Программа для вычисления площади треугольника"
puts ""
print "Введите единицы измерения."
input = gets
var = input.chomp
print "Введите положительное число для основания треугольника."
input = gets
var_1 = input.chomp.to_f
print "Введите положительное число для высоты треугольника."
input = gets
var_2 = input.chomp.to_f
var_3 = 1 / 2.0 * var_1 * var_2
puts "Площадь треугольника равна  #{var_3} кв.#{var}"
puts ""
print "Нажмите 'Enter' для выхода из программы."
input = gets
