class Train

  include NameManufacturer

  attr_accessor :speed
  attr_reader :amount_wagons, :previous_station, :next_station, :real_station

  def initialize
    generate_number
    @speed              = 0
    @number             = generate_number
    @train_route
    @composition_wagons = []
    self.class.add << self
  end

  def find

  end

  #  создать метод класса find, который принимает номер поезда и
  # возвращает объект поезда по номеру или nil, если поезд с таким номером не найден.

  def self.add
    @@add ||= []
  end

  def generate_number
    srand.to_s.slice(1..3)
  end

  def go
    @speed = 10
    speed_train
  end

  def stop
    @speed = 0
    speed_train
  end

  def coupling_wagon(type_vagon)
    stop
    puts "Вагон №#{type_vagon.number} прицеплен к поезду."
    plus_car(type_vagon)
  end

  def upcoupling_wagon(type_vagon)
    stop
    puts "Вагон №#{type_vagon.number} отцеплен от поезда."
    minus_car(type_vagon)
  end

  def type
    if self.class == PassengerTrain
      type = 'Пассажирский'
    elsif self.class == CargoTrain
      type = 'Грузовой'
    end
  end

  def take_route(route)
    self.type
    @train_route   = route
    @route         = route.list_station
    @start_station = @route.first
    puts "#{type} поезд  №#{@number} находится станции #{@start_station}."
  end

  @@indicator = 0
  def along_stations
    @@indicator +=1
    @real_station = @route[@@indicator]
    train_announcement
  end

  def back_station
    @@indicator -=1
    @real_station = @route[@@indicator]
    train_announcement
  end

  def next_station
    next_index    = route.index(@real_station) + 1
    @next_station = route[next_index]
    puts "Следующая станция #{@next_station}"
  end

  def previous_station
    next_index        = route.index(@real_station) - 1
    @previous_station = @route[next_index]
    puts "Предыдущая станция #{@prevous_station}"
  end


  private


  def speed_train
    puts "Скорость поезда #{@speed}"
  end

  def train_announcement
    puts "#{type} поезд №#{@number} прибыл на станцию #{@real_station}."
  end

  def car_announcement
    puts "В составе поезда стало #{@composition_wagons.size} вагонов."
  end

  def minus_car(type_vagon)
    @composition_wagons.delete(type_vagon)
    car_announcement
  end

end