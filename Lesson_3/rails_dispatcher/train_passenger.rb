class PassengerTrain < Train

  def initialize
    super
  end


  private


  def plus_car(type_vagon)
    if type_vagon.is_a?(PassengerCar)
      @composition_wagons << type_vagon
      car_announcement
    else
      puts "Не возможно присоединить грузовой вагон к пассажирскому поезду"
    end
  end

end
