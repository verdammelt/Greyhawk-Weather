require 'baselinedata'
require 'dieroller'
require 'weathergenerator'

class GreyhawkWeatherGenerator
  def create_weather_generator (month, num_days = 1, dieroller = DieRoller.new)
    WeatherGenerator.new BaselineData.new, month, num_days, dieroller
  end
end

