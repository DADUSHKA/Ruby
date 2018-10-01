require_relative 'rails_dispatcher/instance_counter'
require_relative 'rails_dispatcher/name_of_the_manufacturer'
require_relative 'rails_dispatcher/route'
require_relative 'rails_dispatcher/stations'
require_relative 'rails_dispatcher/car'
require_relative 'rails_dispatcher/car_cargo'
require_relative 'rails_dispatcher/car_passenger'
require_relative 'rails_dispatcher/trains'
require_relative 'rails_dispatcher/train_cargo'
require_relative 'rails_dispatcher/train_passenger'

class Main
  attr_reader :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
    main
  end

  def main
    catch (:exit) do
      puts 'Приветствую за виртуальны диспетчерским пультом.'
      loop do
        main_menu
        first_command = command
        throw :exit if first_command == '9'
        case first_command
        when '1'
          option(create_stations)
        when '2'
          option(create_rout_and_stations)
        when '3'
          option(create_train)
        when '4'
          option(give_rout_train)
        when '5'
          option(create_and_add_car_to_train)
        when '6'
          option(unhook_car_from_train)
        when '7'
          option(reliase_train_on_route)
        when '8'
          option(information)
        when '11'
          option(select_stations)
        when 'info'
          option(information)
        else
          option(wrong)
        end
      end
    end
  end

  private

  def main_menu
    puts "Меню управления :
          1 - создать начальную и конечную станции
          2 - создать маршруты и управлять станциями
          3 - создать поезд
          4 - назначить маршрут поезду
          5 - добавить вагоны к поезду
          6 - отцепить вагоны от поезда
          7 - переместить поезд по маршруту вперед и назад
          8 - просмотреть список станций и список поездов на станции
          9 - выход"
  end

  def create_stations
    2.times { create_station }
    rescue StandardError => e
      puts "Erorr: #{e.message}"
      retry
    end

  def create_station
    puts 'Введите с заглавной буквы название  станции:'
    new_station_name = gets.capitalize.chomp
    @stations << Station.new(new_station_name)
    puts "Создана станция назначения '#{new_station_name}'."
  end

  def create_rout_and_stations
    add_route
    add_stations
  rescue StandardError
    puts 'Сначала создайте станции'
  rescue StandardError => e
    puts "Erorr: #{e.message}"
    retry
  end

  def add_route
    @routes << Route.new(@stations.first.name, @stations.last.name)
    puts "Маршрут #{@stations.first.name} - #{@stations.last.name} cоздан."
  end

  def add_stations
    add_station_loop
    puts 'Список станций маршрута:'
    puts @routes.last.list_station.join(', ').to_s
  rescue StandardError => e
    puts "Erorr: #{e.message}"
    retry
  end

  def add_station_loop
    loop do
      puts "Введите:  названия промежуточных станций
                      0 - для выхода "
      @choice = gets.chomp
      break if @choice == '0'

      add_station_curent
    end
  end

  def add_station_curent
    plus_station = Station.new(@choice.capitalize)
    @stations << plus_station
    @routes.last.create_station(plus_station.name)
    puts "Создана станция следования '#{@choice.capitalize}'."
  end

  def create_train
    puts "Выбирите тип поезда:
      1 - пассажирский
      2 - грузовой"
    @selec = gets.chomp
    train_selection
  end

  def train_selection
    selection_type_train
    type_train
    puts "#{type_train} поезд  №#{@trains.last.number} создан."
  rescue StandardError => e
    puts "Erorr: #{e.message}"
    retry
  end

  def selection_type_train
    puts 'Введите номер поезда'
    @number = gets.chomp
    new_train = PassengerTrain.new(@number) if @selec == '1'
    new_train = CargoTrain.new(@number) if @selec == '2'
    @trains << new_train
    @stations.first.receive_trains(new_train) unless @stations.empty?
  end

  def type_train
    if @trains.last.is_a?(PassengerTrain)
      type_train = 'Пассажирский'
    elsif @trains.last.is_a?(CargoTrain)
      type_train = 'Грузовой'
    end
  end

  def give_rout_train
    @trains.last.take_route(@routes.last) unless @routes.empty?
    type_train
    puts "#{type_train} поезд  №#{@trains.last.number} находится станции #{@stations.first.name}."
  rescue StandardError
    puts 'Сначала создайте маршрут и поезд'
  end

  def create_and_add_car_to_train
    puts "Выбирите тип вагона:
      1 - пассажирский
      2 - грузовой"
    @var = gets.chomp
    validate_car
    puts "Введите:
      1 - добавить вагоны к поезду
      0 - выход "
    @object = []
    loop do
      count = gets.chomp
      begin
        break if count == '0'

        create_cars
      rescue StandardError => e
        puts "Erorr: #{e.message}"
        retry
      end
      add_car_to_train
      next if count == '1'
    end
  end

  def validate_car
    puts 'Не правильный тип вагона  ' if @var != '2' &&  @trains.last.is_a?(CargoTrain)
    puts 'Не правильный тип вагона '  if @var != '1' &&  @trains.last.is_a?(PassengerTrain)
  end

  def create_cars
    puts 'Введите номер создаваемого вагона'
    @number = gets.chomp
    puts 'Введите количество мест создаваемого вагона' if @var == '1'
    puts 'Введите объем в тоннах создаваемого вагона' if @var == '2'
    @coun = gets.chomp.to_i
    create_car
  end

  def create_car
    @object << PassengerCar.new(@number, @coun) if @var == '1'
    sale_place if @var == '1'
    @object << CargoCar.new(@number, @coun) if @var == '2'
    load_load if @var == '2'
  end

  def sale_place
    puts 'Занять место в вагоне:
                  1 - купить билет
                  0 - выйти'
    loop do
      coun = gets.chomp
      break if coun == '0'

      @object.last.sale_place
      puts "Осталось свбодных мест #{@object.last.free_places.size}"
      next if coun == '1'
    end
  end

  def load_load
    puts 'Загрузить вагон: введите цифру (т.)'
    space = gets.chomp.to_i
    @object.last.load_load_car(space)
    puts "Вагон загружен на: #{@object.last.load_load.size} (т.)
      свободного места на: #{@object.last.total_space.size} (т.)"
  end

  def add_car_to_train
    type_car
    puts "#{type_car} вагон №#{@object.last.number} создан ."
    @trains.last.coupling_wagon(@object.last) unless @trains.empty?
    message_add_car
  end

  def type_car
    if @object.last.is_a?(PassengerCar)
      type_car = 'Пассажирский'
    elsif @object.last.is_a?(CargoCar)
      type_car = 'Грузовой'
    end
  end

  def message_add_car
    puts "Вагон №#{@object.last.number} прицеплен к поезду."
    puts "В составе поезда стало #{@trains.last.train_length} вагонов."
  end

  def unhook_car_from_train
    puts "Введите:
      1 - отцепить вагон от поезда
      0 - выход "
    loop do
      count = gets.chomp
      break puts 'Все вагоны отцеплены' if @trains.last.composition_wagons.empty?

      unhook
      next if count == '1'
      break if count == '0'
    end
  end

  def unhook
    @trains.last.upcoupling_wagon(@trains.last.composition_wagons.last) unless @trains.empty?
    puts "Вагон №#{@object.last.number} отцеплен от поезда."
    @object.pop
  end

  def reliase_train_on_route
    puts "Движение поезда:
      5 - вперёд
      6 - назад
      0 - стоп"
    loop do
      @go = gets.chomp
      break puts "Поезд прибыл на станцию прибытия #{@stations.last.name}" if
      @trains.last.real_station == @stations.last.name
      break puts "Поезд прибыл на начальную станцию #{@stations.first.name}" if
      @trains.last.real_station == @stations.first.name

      move
      next if @go == '5' && @go == '6'
      break if @go == '0'
    end
  end

  def move
    if @go == '5'
      @trains.last.along_stations unless @trains.empty?
      puts "#{type_train} поезд №#{@trains.last.number} прибыл на станцию #{@trains.last.real_station}."
    else
      @trains.last.back_station unless @trains.empty?
      puts "#{type_train} поезд №#{@trains.last.number} прибыл на станцию #{@trains.last.real_station}."
    end
  end

  def information
    puts '--------------'
    puts
    puts "Создано: #{@trains.size} поездов"
    puts "Создано: #{@routes.size} маршрутов"
    puts '--------------'
    puts 'Cтанции:'
    puts "Создано #{@stations.count} станции"
    puts st.to_s
    puts '--------------'
    puts select_stations.to_s
  end

  def st
    @routes.collect { |i| puts i.list_station.join(', ').to_s }
    nil
  end

  def option(menu_opt)
    menu_opt
    pause
  end

  def pause
    puts "Вернуться к меню: нажать 'Enter' "
    gets
  end

  def command
    puts 'Введите цифру'
    gets.chomp
  end

  def wrong
    puts 'Не правильный выбор команды'
  end

  def enter
    puts "Нажмите 'Enter"
  end

  def select_stations
    puts 'Подробная информации'
    puts
    @stations.each do |station|
      station.takes_a_block_train do |train|
        puts "Станция отправления: #{train.route.first}"
        puts "Станция нахождения: #{train.real_station}"
        puts 'Тип поезда: пассажирский ' if train.class == PassengerTrain
        puts 'Тип поезда: грузовой ' if train.class == CargoTrain
        puts "Номер поезда: №#{train.number}"
        puts "Колличество вагонов: #{train.composition_wagons.size}"
        each_train(train)
      end
    end
    puts '=============='
  end

  def each_train(train)
    train.takes_block_wagon do |car|
      puts "Номер вагона: №#{car.number}"
      puts "Свободных мест: #{car.free_places.size}" if car.class == PassengerCar
      puts "Занятых мест: #{car.occupied_places.size}" if car.class == PassengerCar
      puts "Загружено: #{car.load_load.size}т." if car.class == CargoCar
      puts "Можно загрузить: #{car.total_space.size}т." if car.class == CargoCar
    end
    puts '---------------------'
  end
  end

main = Main.new
