require 'baselinedata'
require 'dieroller'
require 'weather'

class GreyhawkWeatherGenerator
  def generate (day, month, dieroller = DieRoller.new)
    Weather.new BaselineData.new.month(month), dieroller
  end
end

