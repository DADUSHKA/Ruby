class CargoTrain < Train

  def initialize
    super
     puts "#{type} поезд №#{@number} создан."
  end


  private


  def plus_car(type_vagon)
    if type_vagon.is_a?(CargoCar)
      @composition_wagons << type_vagon
      car_announcement
    else
      puts "Не возможно присоединить пассажирский вагон к грузовому поезду"
    end
  end

end
