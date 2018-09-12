puts "Программа для определения геометрии треугольника."
puts
print "Введите положительное число для стороны 'а'."
a = gets.to_f
print "Введите положительное число для стороны 'b'."
b = gets.to_f
print "Введите положительное число для стороны 'c'."
c = gets.to_f

puts 'Треугольник не прямоугольный' unless a > b && a > c || b > a && b > c || c > b && c > a

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

gipotenuza = gipotenuza**2
side = side1**2 + side2**2

if a == b && a == c
  puts 'Треугольник равносторонний.'
elsif gipotenuza.to_i == side.to_i && side1 == side2
  puts
  puts 'Треугольник прямоугольный и равнобедренный'
elsif gipotenuza.to_i == side.to_i
  puts
  puts 'Треугольник прямоугольный'
else
  puts 'Треугольник не прямоугольный'
end

puts
print "Нажмите 'Enter' для выхода из программы."
gets
