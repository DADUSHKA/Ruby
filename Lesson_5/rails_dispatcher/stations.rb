class Station

  include InstanceCounter

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
  end

  def receive_trains(train)
    @list_all_train << train
  end

  def send_trains(train)
    @list_all_train.delete(train)
  end

end
