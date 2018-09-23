class Car

  include NameManufacturer
<<<<<<< HEAD
=======
  include InstanceCounter
>>>>>>> moduls_and_trains

  attr_reader :number

  def initialize
    @number = generate_number
    self.class.add << self
  end

  def generate_number
    rand(10).to_s
  end

  def self.add
    @@add ||= []
  end

end
