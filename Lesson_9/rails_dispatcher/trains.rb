class Train
  include NameManufacturer
  include InstanceCounter
  include Validation
  extend Acсessors

  NAMBER_TRAIN = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i

  my_attr_accessor :color, :power
  strong_attr_accessor(:strong_attrb, String)
  attr_accessor :speed, :number
  attr_reader :real_station, :composition_wagons, :route

  validate :name, :presence
  validate :name, :format, NUMBER_TRAIN
  validate :type_class, :type, 'Train'

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

  def initialize(number)
    @real_station = 'станция отправления'
    register_instance
    @speed              = 0
    @number             = number
    @train_route        = nil
    @composition_wagons = []
    self.class.add << self
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def go
    @speed = 10
  end

  def stop
    @speed = 0
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
    @@indicator += 1
    @real_station = @route[@@indicator]
  end

  def back_station
    @@indicator -= 1
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

  def takes_block_wagon(&_block)
    @composition_wagons.each { |wagon| yield wagon } if block_given?
  end

  protected

  def validate!
    raise 'Не правильно введен номер поезда' if number !~ NAMBER_TRAIN
  end
end
