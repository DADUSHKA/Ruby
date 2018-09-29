class Station
  include InstanceCounter

  STATION_NAME = /\A[A-Z][a-z]+$/

  attr_reader :list_all_train, :list_type_train, :name

  @@add = []

  def self.add
    @@add ||= []
  end

  def self.all
    @@add.map { |i| p i.name.to_s } unless @@add.nil?
  end

  def initialize(name)
    @name           = name
    @list_all_train = []
    self.class.add << self
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def receive_trains(train)
    @list_all_train << train
  end

  def send_trains(train)
    @list_all_train.delete(train)
  end

  def takes_a_block_train(&_block)
    @list_all_train.each { |train| yield train } if block_given?
  end

  private

  def validate!
    raise 'Введите название станции' unless name
    raise 'Введите название станции с большой буквы' if name !~ STATION_NAME
  end
end
