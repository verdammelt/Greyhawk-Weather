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
    else "ERROR: SkyCondition.condition " + roll.to_s \
      + " doesn't match ranges " + @clear_range.to_s \
      + " or " + @partly_range.to_s \
      + " or " + @cloudy_range.to_s
    end
  end
end

