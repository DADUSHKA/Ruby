class CargoCar < Car

  def initialize
    super
    @type = :cargo
    puts "Создан вагон №#{@number} типа #{@type}."
  end

end
