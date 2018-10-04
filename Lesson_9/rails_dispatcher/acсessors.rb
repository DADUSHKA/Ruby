module Acсessors
  def my_attr_accessor(*names)
    names.each do |name|
      define_method(name) { instance_variable_get("@#{name}".to_sym) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set("@#{name}".to_sym, value)
        arr_value = instance_variable_get("@#{name}_history".to_sym) || []
        instance_variable_set("@#{name}_history".to_sym, arr_value << value)
      end
      define_method("#{name}_history".to_sym) { instance_variable_get("@#{name}_history".to_sym) }
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      instance_variable_set(var_name, value) if value.is_a?(type)
      raise 'Введите правильный тип атрибута'
    end
  end
end
