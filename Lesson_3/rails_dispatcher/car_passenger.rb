class PassengerCar < Car

  def initialize
    super
    @type = :passenger
    puts "Создан вагон №#{@number} типа #{@type}."
  end

end
