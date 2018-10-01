class CargoCar < Car
  attr_reader :total_space, :load_load, :load_load_car

  def initialize(number, total_space)
    super
    @total_space = []
    total_space.times { |i| @total_space << i }
    @load_load = []
  end

  def load
    @load_load << @total_space.delete_at(1)
  end

  def load_load_car(var)
    var.times { |_i| load }
  end
end
