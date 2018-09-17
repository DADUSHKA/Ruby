class Station

  attr_reader :list_all_train, :list_type_train

  def initialize(name)
    @name           = name
    @list_all_train = []
  end

  def receive_trains(train)
    @list_all_train << train
  end

  def send_trains(train)
    @list_all_train.delete(train)
  end

  def trains_calc(type)
    counter = 0
    list_all_train.each do |train|
      counter += 1 if train.type == type
    end
    puts "#{type} - #{counter} шт."
  end

end
