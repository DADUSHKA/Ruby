class Train

  include NameManufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :amount_wagons, :previous_station, :next_station, :real_station, :number

  def self.find(number)
    object = nil
    @@add.each { |i| object = i if i.number.to_i == number } unless @add.nil?
    p object
  end

  @@add = []

  def initialize
    @speed              = 0
    @number             = generate_number
    @train_route
    @composition_wagons = []
    register_instance
    self.class.add << self
  end

  def self.add
    @@add ||= []
  end

  def generate_number
    rand(10).to_s
  end

  def self.add
    @@add ||= []
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
     @composition_wagons << type_vagon
  end

  def train_length
    @composition_wagons.size
  end

  def upcoupling_wagon(type_vagon)
    stop
    puts "Вагон №#{type_vagon.number} отцеплен от поезда."
    @composition_wagons.delete(type_vagon)
  end

  def take_route(route)
    @train_route   = route
    @route         = route.list_station
    @start_station = @route.first
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

end
