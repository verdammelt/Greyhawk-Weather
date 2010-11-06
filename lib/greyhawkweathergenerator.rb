require 'baselinedata'
require 'dieroller'
require 'weathergenerator'

class GreyhawkWeatherGenerator
  def self.create_weather_generator (month, num_days = 1, dieroller = DieRoller.new)
    WeatherGenerator.new BaselineData.load("data/baselinedata.yml"), PrecipitationOccurance.load("data/precipitationoccurance.yml"), month, num_days, dieroller
  end
end

