module InstanceCounter

  # instances, который возвращает кол-во экземпляров данного класса
  module ClassMethods
    def instances
      self.add.size
    end
  end



  # register_instance, который увеличивает счетчик кол-ва экземпляров класса и
  # который можно вызвать из конструктора. При этом, данный метод не должен быть публичным.
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

end
