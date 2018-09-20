class Route

  attr_reader :start_station, :list_station

  def initialize(start_station, finish_station)
    @list_station   = [start_station, finish_station]
    @start_station  = start_station
    @finish_station = finish_station
    self.class.all << self
    puts "Маршрут #{@start_station} - #{@finish_station} cоздан."
  end

  def self.all
    @all ||= []
  end

  def info
    puts Route.all
  end

  def create_station(station)
    @list_station.delete_at(0)
    @list_station.delete_at(-1)
    @list_station << station
    @list_station.insert(0, @start_station)
    @list_station.insert(-1, @finish_station)
    self
  end

  def delete_station(station)
    @list_station.delete(station) if @list_station.length > 2
  end

end
