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

  def initialize
    @stations = Station.add
    @routes = Route.add
    @trains = Train.add
    @cars = Car.add
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
          option(create_rout_and_stations)
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
    puts "Введите название первой станции:"
    new_station_name = gets.chomp
    Station.new(new_station_name)
    puts "Введите название второй станции:"
    new_station_name = gets.chomp
    Station.new(new_station_name)
  end

  def create_rout_and_stations
    if @stations.empty?
      puts "Сначала создайте станции"
      gets
    else
      Route.new(@stations.first.name, @stations.last.name)
      add_station
    end
  end

  def add_station
    loop do
      puts "Введите:
           названия промежуточных станций
           0 - для выхода "
      station = gets.chomp

      break if station == '0'
      @routes.last.create_station(Station.new(station).name)
    end
  end

  def create_train
    puts "Выбирите тип поезда:
        1 - пассажирский
        2 - грузовой"
    var = gets.chomp
    if var == '1'
      @stations.first.receive_trains(PassengerTrain.new) unless @stations.empty?
       puts "Пассажирский поезд №#{@number} создан."
    else
      @stations.first.receive_trains(CargoTrain.new) unless @stations.empty?

    end
  end

  # def create_train_passanger

  #   def type
  #   if self.class == PassengerTrain
  #     type = 'Пассажирский'
  #     PassengerTrain.new
  #   elsif self.class == CargoTrain
  #     type = 'Грузовой'
  #     CargoTrain.new
  #   end
  # end

  # end

#   def create_train_cargo
# CargoTrain.new
# puts "Грузовой поезд №#{CargoTrain.new.number} создан."
#   end

  def give_rout_train
    @trains.last.take_route(@routes.last) unless @routes.empty?
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
    loop do
      count = gets.chomp
      PassengerCar.new unless @trains.empty?
      @trains.last.coupling_wagon(@cars.last) unless @trains.empty?
      next if count == '1'
      break if count == '0'
    end
  end

  def add_car_to_cargo_train
    puts "Введите:
        1 - добавить вагоны к поезду
        0 - выход "
    loop do
      count = gets.chomp
      CargoCar.new unless @trains.empty?
      @trains.last.coupling_wagon(@cars.last) unless @trains.empty?
      next if count == '1'
      break if count == '0'
    end
  end

  def unhook_car_from_train
    @trains.last.upcoupling_wagon(@cars.last) unless @trains.empty?
  end

  def reliase_train_on_route
    puts "Движение поезда:
          5 - вперёд
          6 - назад
          0 - стоп"
    loop do
      count = gets.chomp
      if count == '5'
        @trains.last.along_stations unless @trains.empty?
      else
        @trains.last.back_station unless @trains.empty?
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

end
 main = Main.new
