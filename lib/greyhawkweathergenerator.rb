require 'baselinedata'
require 'util/dieroller'
require 'weathergenerator'
require 'options'

class GreyhawkWeatherGenerator
  def self.create_weather_generator (options)
    WeatherGenerator.new(BaselineData.load("data/baselinedata.yml"), 
                         PrecipitationOccurance.load("data/precipitationoccurance.yml"), 
                         options.month, 
                         options.num_days, 
                         options.dieroller,
                         options.terrain)
  end
end

