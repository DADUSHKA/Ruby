class Train

  attr_accessor :speed
  attr_reader :amount_wagons, :number, :type, :train_route, :real_station,
    :start_station, :route, :previous_station, :next_station

  def initialize(number="", type="", amount_wagons=0)
    @number        = number
    @type          = type
    @amount_wagons = amount_wagons
    @train_route
  end

  def stop
    @speed = 0
  end

  def coupling_wagon
    if @speed == 0
      @amount_wagons +=1
    else
      stop
      @amount_wagons +=1
    end
  end

  def upcoupling_wagon
    if @speed > 0
      stop
      if @amount_wagons > 0
        @amount_wagons -=1
      end
    end
  end

  def take_route(route)
    @train_route   = route
    @route         = route.list_station
    @start_station = @route.first
  end

  @@var = 0
  def along_stations
    @@var +=1
    @real_station = @route[@@var]
  end

  def back_station
    @@var -=1
    @real_station = @route[@@var]
  end

  def next_station
    next_index    = route.index(@real_station) + 1
    @next_station = @route[next_index]
  end

  def previous_station
    next_index    = route.index(@real_station) - 1
    @next_station = @route[next_index]
  end

end
