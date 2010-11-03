class SkyConditions
  def initialize (clear_range, partly_range, cloudy_range)
    @clear_range = clear_range
    @partly_range = partly_range
    @cloudy_range = cloudy_range
  end
  
  def condition(roll)
    roll = 100 if roll == 0
    case roll
    when @clear_range then :clear
    when @partly_range then :partly_cloudy
    when @cloudy_range then :cloudy
    else :unknown
    end
  end
end

