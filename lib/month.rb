require 'skyconditions'
require 'temperaturerange'

class Month
  def initialize(temp_range = TemperatureRange.new(0, [0, 0], [0, 0]), 
                 conditions = SkyConditions.new((0..100), (100..100), (100..100)), 
                 precipitation_chance = 0)
    @temp_range = temp_range
    @sky_condition = conditions
    @precipitation_chance = precipitation_chance
  end
  
  def sky_conditions (dieroller)
    @sky_condition.condition(dieroller)
  end
  
  def temp_range (dieroller, record_temp=nil)
    @temp_range.range(dieroller, record_temp)
  end
  
  def precipitation (dieroller)
    @precipitation_chance >= dieroller.roll(100)
  end
end

