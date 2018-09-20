

class PassengerTrain < Train

  def initialize
    super
    @type = :passenger
    puts " Поезд №#{@number} типа #{@type} создан."
  end


  private

  def plus_car(type_vagon)
    if type_vagon.type == :passenger
      @composition_wagons << type_vagon
      car_announcement
    else
      puts "Не возможно присоединить грузовой вагон к пассажирскому поезду"
    end
  end

end
