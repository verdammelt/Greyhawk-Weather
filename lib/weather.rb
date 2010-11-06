require 'month'

class Weather
  attr_reader :temperature_range
  attr_reader :sky_conditions
  attr_reader :precipitation
  
  def initialize (month, dieroller)
    @temperature_range = month.temp_range(dieroller)
    @sky_conditions = month.sky_conditions(dieroller)
    @precipitation = month.precipitation(dieroller)
  end
  
  def dump
    p [@temperature_range, @sky_conditions, @precipitation]
  end
end

