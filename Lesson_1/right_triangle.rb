puts "Программа для определения геометрии треугольника."
puts ""
print "Введите положительное число для стороны 'а'."
a = gets.to_f
print "Введите положительное число для стороны 'b'."
b = gets.to_f
print "Введите положительное число для стороны 'c'."
c = gets.to_f

if a > b && a > c
  gipotenuza = a
  side1 = b
  side2 = c
elsif b > a && b > c
  gipotenuza = b
  side1 = a
  side2 = c
elsif c > b && c > a
  gipotenuza = c
  side1 = a
  side2 = b
end

if a == b && a == c
  puts 'Треугольник равнобедренный.'
elsif gipotenuza**2 == side1**2 + side2**2
  puts 'Треугольник прямоугольный'
else
  puts 'Треугольник НЕ прямоугольный'
end
puts ""
print "Нажмите 'Enter' для выхода из программы."
input = gets
