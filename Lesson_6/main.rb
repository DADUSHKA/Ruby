require_relative "rails_dispatcher/instance_counter"
require_relative "rails_dispatcher/name_of_the_manufacturer"
require_relative "rails_dispatcher/route"
require_relative "rails_dispatcher/stations"
require_relative "rails_dispatcher/car"
require_relative "rails_dispatcher/car_cargo"
require_relative "rails_dispatcher/car_passenger"
require_relative "rails_dispatcher/trains"
require_relative "rails_dispatcher/train_cargo"
require_relative "rails_dispatcher/train_passenger"


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
      puts "Приветствую за виртуальны диспетчерским пультом."
      loop do
        main_menu
        first_command = command
        throw :exit if first_command == "9"
        case first_command
        when "1"
          option(create_station)
        when "2"
          option(create_rout_and_stations )
        when "3"
          option(create_train)
        when "4"
          option(give_rout_train)
        when "5"
          option(add_car_to_train)
        when "6"
          option(unhook_car_from_train)
        when "7"
          option(reliase_train_on_route)
        when "8"
          option(information)
        when "info"
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

  def create_station
    begin
      puts "Введите с заглавной буквы название первой станции:"
      new_station_name = gets.chomp
      @stations << Station.new(new_station_name)
      puts "Создана станция назначения '#{new_station_name}'."
      puts "Введите с заглавной буквы название второй станции:"
      new_station_name = gets.chomp
      @stations << Station.new(new_station_name)
      puts "Создана станция прибытия '#{new_station_name}'."
    rescue => e
      puts "Erorr: #{e.message}"
      retry
    end
  end

  def create_rout_and_stations
    begin
      @routes << Route.new(@stations.first.name, @stations.last.name)
      puts "Маршрут #{@stations.first.name} - #{@stations.last.name} cоздан."
      add_station
    rescue
      puts "Сначала создайте станции"
    rescue => e
      puts "Erorr: #{e.message}"
      retry
    end
  end

  def add_station
    begin
      loop do
        puts "Введите:
           названия промежуточных станций
           0 - для выхода "
        station = gets.chomp
        break if station == '0'
        plus_station = Station.new(station)
        @stations << plus_station
        @routes.last.create_station(plus_station.name)
        puts "Создана станция следования '#{station}'."
      rescue => e
        puts "Erorr: #{e.message}"
        retry
      end
    end
  end

  def create_train
    puts "Выбирите тип поезда:
        1 - пассажирский
        2 - грузовой"
    @selec = gets.chomp
    train_selection
  end

  def train_selection
    begin
      if @selec == '1'
        puts "Введите номер поезда"
        number = gets.chomp
        new_train = PassengerTrain.new(number)
        @trains << new_train
        @stations.first.receive_trains(new_train) unless @stations.empty?
        puts "Пассажирский поезд №#{@trains.last.number} создан."
      else
        puts "Введите номер поезда"
        number = gets.chomp
        new_train = CargoTrain.new(number)
        @trains << new_train
        @stations.first.receive_trains(new_train) unless @stations.empty?
        puts "Грузовой поезд №#{@trains.last.number} создан."
      end
    rescue => e
      puts "Erorr: #{e.message}"
      retry
    end
  end

  def type_train
    if @trains.last.is_a?(PassengerTrain)
      type_train = 'Пассажирски'
    elsif @trains.last.is_a?(CargoTrain)
      type_train = 'Грузовой'
    end
  end

  def give_rout_train
    begin
      @trains.last.take_route(@routes.last) unless @routes.empty?
      type_train
      puts "#{type_train} поезд  №#{@trains.last.number} находится станции #{@stations.first.name}."
    rescue
      puts "Сначала создайте маршрут и поезд"
    end
  end

  def add_car_to_train
    puts "Выбирите тип поезда:
        1 - пассажирский
        2 - грузовой"
    var = gets.chomp
    if var == '1'
      add_car_to_passenger_train
    else
      add_car_to_cargo_train
    end
  end

  def add_car_to_passenger_train
    puts "Введите:
        1 - добавить вагоны к поезду
        0 - выход "
    @object = []
    loop do
      count = gets.chomp
      puts "Введите номер создаваемого вагона"
      number = gets.chomp
      begin
        @object << PassengerCar.new(number) unless @trains.empty?
        puts "Пассажирский вагон №#{@object.last.number} создан ."
        @trains.last.coupling_wagon(@object.last) unless @trains.empty?
        message_add_car
      rescue => e
        puts "Erorr: #{e.message}"
        enter
      end
      next if count == '1'
      break if count == '0'
    end
  end

  def message_add_car
    puts "Вагон №#{@object.last.number} прицеплен к поезду."
    puts "В составе поезда стало #{@trains.last.train_length} вагонов."
  end

  def add_car_to_cargo_train
    puts "Введите:
        1 - прицепить вагон к поезду
        0 - выход "
    @object = []
    loop do
      count = gets.chomp
      puts "Введите номер создаваемого вагона"
      number = gets.chomp
      begin
        @object << CargoCar.new(number) unless @trains.empty?
        puts "Грузовой вагон №#{@object.last.number} создан ."
        @trains.last.coupling_wagon(@object.last) unless @trains.empty?
        message_add_car
      rescue => e
        puts "Erorr: #{e.message}"
        enter
      end
      next if count == '1'
      break if count == '0'
    end
  end

  def unhook_car_from_train
    puts "Введите:
        1 - отцепить вагон от поезда
        0 - выход "
    loop do
      count = gets.chomp
      break puts "Все вагоны отцеплены"if @trains.last.composition_wagons.empty?
        @trains.last.upcoupling_wagon(@trains.last.composition_wagons.last) unless @trains.empty?
        puts "Вагон №#{@object.last.number} отцеплен от поезда."
        @object.pop
        next if count == '1'
        break if count == '0'
      end
    end

    def reliase_train_on_route
      puts "Движение поезда:
          5 - вперёд
          6 - назад
          0 - стоп"
      loop do
        count = gets.chomp
        break puts "Поезд прибыл на станцию прибытия #{@stations.last.name}" if
        @trains.last.real_station == @stations.last.name
        break puts "Поезд прибыл на начальную станцию #{@stations.first.name}" if
        @trains.last.real_station == @stations.first.name
        if count == '5'
          @trains.last.along_stations unless @trains.empty?
          puts "#{type_train} поезд №#{@trains.last.number} прибыл на станцию #{@trains.last.real_station}."
        else
          @trains.last.back_station unless @trains.empty?
          puts "#{type_train} поезд №#{@trains.last.number} прибыл на станцию #{@trains.last.real_station}."
        end
        next if count == '5' && count == '6'
        break if count == '0'
      end
    end

    def information
      puts "сколько"
      puts "Создано: #{@trains.size} поездов"
      puts "Создано: #{@routes.size} маршрутов"
      puts "--------------"
      puts "Cтанции:"
      puts "Создано #{@stations.count} станций"
      puts "#{st}"
    end

    def st
      @routes.collect { |i| puts "#{i.list_station.join(", ")}"}
      return
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
      puts "Введите цифру"
      gets.chomp
    end

    def wrong
      puts "Не правильный выбор команды"
    end

    def enter
      puts "Нажмите 'Enter"
    end

  end

  main = Main.new
