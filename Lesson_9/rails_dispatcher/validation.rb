module Validation
  module ClassMethods
    def validate(name, *params)
      validates_obj = '@validates'
      instance_variable_get(validates_obj)[name] = *params
      instance_variable_set(validates_obj, {}) unless instance_variable_defined?(validates_obj)
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get('@validates').each do |name, params|
        send("validate_#{params[0]}", name, *params[1, params.size])
      end
      true
    end

    def valid?
      validate!
    rescue ArgumentError
      false
    end

    private

    def validate_presence(name)
      value = instance_variable_get("@#{name}")
      raise 'Пустой аргумент!' if value.nil? || value.empty?
    end

    def validate_format(name, format, message = 'Не правильный формат ввода!')
      value = instance_variable_get("@#{name}")
      raise ArgumentError, message unless value =~ format
    end

    def validate_type(name, type, message = 'Не совпадение типов!')
      type_class = instance_variable_get("@#{name}").to_s
      raise ArgumentError, message if type_class != type
    end
  end

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
end
