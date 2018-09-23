module InstanceCounter

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

end
