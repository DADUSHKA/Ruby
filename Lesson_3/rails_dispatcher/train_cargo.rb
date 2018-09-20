

class CargoTrain < Train

  def initialize
    super
    @type = :cargo
    puts " Поезд №#{@number} типа #{@type} создан."
  end



  private

  def plus_car(type_vagon)
    if type_vagon.type == :cargo
      @composition_wagons << type_vagon
      car_announcement
    else
      puts "Не возможно присоединить пассажирский вагон к грузовому поезду"
    end
  end

end
