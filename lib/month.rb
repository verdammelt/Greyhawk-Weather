class Month
  attr_reader :temperature
  attr_reader :range_deltas

  def initialize(temperature, range_deltas = { :high => [0, 0], :low => [0, 0] })
    @temperature = temperature
    @range_deltas = range_deltas
  end
end

