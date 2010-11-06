require 'rangehash'

class SkyConditions
  def initialize (clear_range, partly_range, cloudy_range)
    hash = { clear_range => :clear, partly_range => :partly_cloudy, cloudy_range => :cloudy}
    @condition_ranges = RangeHash.new(hash , :none)
  end
  
  def condition(roll)
    roll = 100 if roll == 0
    @condition_ranges[roll]
  end
end

