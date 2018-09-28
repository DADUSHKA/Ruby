class Station

  include InstanceCounter

  STATION_NAME = /\A[A-Z][a-z]+$/

  attr_reader :list_all_train, :list_type_train, :name

  @@add = []

  def self.add
    @@add ||= []
  end

  def self.all
    @@add.map { |i| p "#{i.name}"} unless @@add.nil?
    return
  end

  def initialize(name)
    @name           = name
    @list_all_train = []
    self.class.add << self
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def receive_trains(train)
    @list_all_train << train
  end

  def send_trains(train)
    @list_all_train.delete(train)
  end


  private


  def validate!
    raise "Введите название станции" if name.nil?
    raise "Введите название станции с большой буквы" if name !~ STATION_NAME
  end

end
