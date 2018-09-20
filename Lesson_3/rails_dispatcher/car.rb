class Car

  attr_reader :type, :number

  def initialize
    @number = generate_number
    self.class.all << self
  end

  def generate_number
    rand(10).to_s
  end

  def self.all
    @@all ||= []
  end

end
