class  Car

  attr_reader :free_places, :occupied_places

  def initialize(number, count)
    @free_places = []
    count.times{|i| @free_places << i}
    @occupied_places = []
     @number = number
  end

  def sale_place
    @occupied_places << @free_places.delete_at(1)
  end

end
