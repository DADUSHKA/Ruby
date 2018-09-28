
class Test

def initialize(var)
  begin
  @var = var
valid!
rescue
  puts "Work"
end
end

def valid!
  raise "Malo" if var.length > 3
end













end






























































# class PorridgeError < StandardError
# end
# class BeddingError < StandardError
# end
# def eat
#   raise PorridgeError, "too hot"
# end
# def sleep
#   raise BeddingError, "too soft"
# end
# begin
#   eat
# rescue  PorridgeError => error
#   puts "This bed is #{error.message}!"
# end


# class OvenOffError < StandardError
# end
# class OvenEmptyError < StandardError
# end


# class SmallOven
#   attr_accessor :contents
#   def turn_on
#     puts "Включение духовки."
#     @state = "on"
#   end
#   def turn_off
#     puts "Выключение духовки."
#     @state = "off"
#   end
#   def bake
#     unless @state == "on"
#       raise OvenOffError, "Сначала вам нужно включить духовку!!"
#     end
#     if @contents == nil
#       raise OvenEmptyError, "В духовке ничего нет!"
#     end
#     "золотисто-коричневый #{contents}"
#   end
# end



# dinner = ['turkey', nil, 'pie']
# oven = SmallOven.new
# oven.turn_off
# dinner.each do |item|
#   begin
#     oven.contents = item
#     puts "Порция #{oven.bake}."
#   rescue OvenEmptyError => error
#     puts "Error: #{error.message}"
#   rescue OvenOffError => error
#     oven.turn_on
#     retry
#   end
# end

# def method_name
# 	raise "В духовке ничего нет!"
# end


# begin
# 	 method_name
# # rescue  => e
# # 	 puts "Error: #{e.message}"
# 	ensure
# 		puts 'adfdf====fdfa'
# end
