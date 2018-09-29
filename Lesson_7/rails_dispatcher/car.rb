class Car
  include NameManufacturer

  attr_reader :number

  def initialize(number)
    @number = number
    validate!
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Введите номер' unless @number
    raise 'Введите правильно номер' if number.length > 3
  end
end
