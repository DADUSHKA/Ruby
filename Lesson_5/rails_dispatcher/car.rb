class Car

  include NameManufacturer

  attr_reader :number

  def initialize
    @number = generate_number
  end

  def generate_number
    rand(10).to_s
  end

end
