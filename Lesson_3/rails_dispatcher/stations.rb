class Station

  attr_reader :list_all_train, :list_type_train

  def initialize(name)
    @name = name
    @list_all_train = []
  end

  def receive_trains(train)
    @list_all_train << train
  end

  def send_trains(train)
    @list_all_train.delete(train)
  end

  def trains_calc
    cargo, passenger = [0,0]
    list_all_train.each do |train|
      cargo     += 1 if train.type == "cargo"
      passenger += 1 if train.type == "passenger"
    end
    [cargo, passenger]
  end

  def list_type_train
    puts "cargo - #{trains_calc[0]}"
    puts "passenger - #{trains_calc[1]}"
  end

end
