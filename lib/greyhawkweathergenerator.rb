require 'baselinedata'
require 'util/dieroller'
require 'weathergenerator'

class GreyhawkWeatherGenerator
  def self.create_weather_generator (month_index, num_days = 1, dieroller = DieRoller.new, terrain = :plains)
    WeatherGenerator.new(BaselineData.load("data/baselinedata.yml"), 
                         PrecipitationOccurance.load("data/precipitationoccurance.yml"), 
                         month_index, 
                         num_days, 
                         dieroller,
                         terrain)
  end
end

