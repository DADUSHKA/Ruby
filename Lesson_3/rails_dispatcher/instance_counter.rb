module InstanceCounter

<<<<<<< HEAD
# instances, который возвращает кол-во экземпляров данного класса


# register_instance, который увеличивает счетчик кол-ва экземпляров класса и
# который можно вызвать из конструктора. При этом, данный метод не должен быть публичным.
=======
  module ClassMethods
    def instances
      self.add.size
    end
  end


  module InstanceMethods

    private

    def register_instance
      self.class.instances
    end
  end


  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
>>>>>>> moduls_and_trains

end
