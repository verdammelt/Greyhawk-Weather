require 'skyconditions'

class Month
  def initialize(temp_range = TemperatureRange.new(0, [0, 0], [0, 0]), conditions = SkyConditions.new((0..100), (100..100), (100..100)))
    @temp_range = temp_range
    @sky_condition = conditions
  end
  
  def sky_conditions (dieroller)
    @sky_condition.condition(dieroller.roll(100, 0))
  end
  
  def temp_range (dieroller)
    @temp_range.range(dieroller)
  end
end

