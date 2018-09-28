class Car

  include NameManufacturer

  attr_reader :number

  def initialize(number)
    @number = number
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end


  private


  def validate!
    raise "Введите номер" if number.nil?
    raise "Введите правильно номер" if number.length > 3
    true
  end

  # def generate_number
  #   rand(10).to_s
  # end

end
