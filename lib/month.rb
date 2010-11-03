require 'skyconditions'

class Month
  attr_reader :temperature
  attr_reader :range_deltas

  def initialize(temperature, range_deltas = { :high => [0, 0], :low => [0, 0] }, conditions = SkyConditions.new((0..100), (100..100), (100..100)))
    @temperature = temperature
    @range_deltas = range_deltas
    @sky_condition = conditions
  end
  
  def sky_conditions (dieroll)
    @sky_condition.condition(dieroll)
  end
end

