class Month
  attr_reader :temperature
  attr_reader :range_deltas
  attr_reader :sky_conditions_ranges

  def initialize(temperature, range_deltas = { :high => [0, 0], :low => [0, 0] }, sky_condition_ranges = { :clear => (0..99)})
    @temperature = temperature
    @range_deltas = range_deltas
    @sky_condition_ranges = sky_condition_ranges
  end
  
  def conditions (dieroll)
    @sky_condition_ranges.find{ |kv| kv[1].include?(dieroll)}[0]
  end
end

