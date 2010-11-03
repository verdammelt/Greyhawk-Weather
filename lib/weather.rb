require 'month'

class Weather
  attr_reader :temperature_range
  attr_reader :sky_conditions
  
  def initialize (month, dieroller)
    @temperature_range = month.temp_range(dieroller)
    @sky_conditions = month.sky_conditions(dieroller)
  end
  
  def dump
    p [@temperature_range, @sky_conditions]
  end
end

