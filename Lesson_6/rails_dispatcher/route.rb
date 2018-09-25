class Route

  include InstanceCounter

  attr_reader :list_station

  def self.add
    @@add ||= []
  end

  def initialize(start_station, finish_station)
    @list_station   = [start_station, finish_station]
    @start_station  = start_station
    @finish_station = finish_station
    self.class.add << self
    register_instance
  end

  def create_station(station)
    @list_station.delete_at(0)
    @list_station.delete_at(-1)
    @list_station << station
    @list_station.insert(0, @start_station)
    @list_station.insert(-1, @finish_station)
  end

  def delete_station(station)
    @list_station.delete(station) if @list_station.length > 2
  end

end
