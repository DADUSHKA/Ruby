class Train

  attr_accessor :speed
  attr_reader :amount_wagons, :previous_station, :next_station, :real_station

  def initialize(number = "", type = "", amount_wagons = 0)
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

  # Я использовал переменную класса,
  # чтобы отслеживать количество
  # запросов к методам 'along_stations, back_station'
  # и использовать эту переменную в виде счетчика
  # для индексов массива названий станций.

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
    @next_station = @route[next_index]
  end

  def previous_station
    next_index        = route.index(@real_station) - 1
    @previous_station = @route[next_index]
  end

end
