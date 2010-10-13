require 'month'

class Weather
  attr_reader :temperature_range
  attr_reader :base_temperature
  
  def initialize (month, dieroller)
    @dieroller = dieroller
    @base_temperature = month.temperature

    high_range = month.range_deltas[:high]
    low_range = month.range_deltas[:low]

    @temperature_range = 
      Range.new(month.temperature - dieroller.roll(low_range[0], low_range[1]),
                month.temperature + dieroller.roll(high_range[0], high_range[1]))
  end
                
  
  def dump
    p [@base_temperature, @temperature_range]
  end
end

