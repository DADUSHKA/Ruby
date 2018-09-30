class  Car



attr_reader :total_space

  def initialize(number, total_space)
   @number = number
    @total_space = []
    total_space.times{|i| @total_space << i}
    @load_load = []
  end

def load
  @load_load <<  @total_space.delete_at(1)
end

def load_load(var)
  var.times{|i| load }
end






end
