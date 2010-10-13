require 'baselinedata'
require 'weather'

class GreyhawkWeatherGenerator
  def generate (day, month)
    Weather.new BaselineData.new.month(month)
  end
end

