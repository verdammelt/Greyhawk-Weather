require 'rangehash'

class SkyConditions
  def initialize (clear_range, partly_range, cloudy_range)
    hash = { clear_range => :clear, partly_range => :partly_cloudy, cloudy_range => :cloudy}
    @condition_ranges = RangeHash.new(:none)
    @condition_ranges.merge! hash
  end
  
  def condition(roller)
    roll = roller.roll(100)
    roll = 100 if roll == 0
    @condition_ranges[roll]
  end
end

