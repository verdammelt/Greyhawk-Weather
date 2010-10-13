require 'month'

class Weather
  attr_reader :temperature_range
  attr_reader :base_temperature
  
  def initialize (month)
    @base_temperature = month.temperature
    @temperature_range = [month.temperature...month.temperature]
  end
  
  def dump
    p [@base_temperature]
  end
end

