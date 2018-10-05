class Station
  include InstanceCounter
  include Validation
  extend Acсessors

  STATION_NAME = /\A[A-Z][a-z]+$/

  my_attr_accessor :town, :terminal
  strong_attr_accessor(:strong_attrb, String)
  attr_reader :list_all_train, :list_type_train, :name

  validate :name, :presence
  validate :type_class, :type, 'Station'

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
