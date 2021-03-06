class Train

  include NameManufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :real_station, :number, :composition_wagons, :route

  def self.find(number)
    object = nil
    @@add.each { |i| object = i if i.number.to_i == number } unless @add.nil?
    p object
  end

  @@add = []

  def self.add
    @@add ||= []
  end

  def self.indicator
    @@indicator
  end

  def initialize
    register_instance
    @speed              = 0
    @number             = generate_number
    @train_route
    @composition_wagons = []
    self.class.add << self
  end

  def generate_number
    rand(10).to_s
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
  end

  def back_station
    @@indicator -=1
    @real_station = @route[@@indicator]
  end

  def next_station
    next_index    = route.index(@real_station) + 1
    @next_station = route[next_index]
  end

  def previous_station
    next_index        = route.index(@real_station) - 1
    @previous_station = @route[next_index]
  end


  protected


  def speed_train
    puts "Скорость поезда #{@speed}"
  end

end
