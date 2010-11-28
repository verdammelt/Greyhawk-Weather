require 'month'
require 'precipitationoccurance'
require 'precipitationinfo'
require 'wind'

class SingleDayWeather
  attr_reader :temperature_range
  attr_reader :sky_conditions
  attr_reader :precipitation
  attr_reader :wind
  
  def initialize (month, dieroller, 
                  precipitation_occurance_chart=PrecipitationOccurance.new({ 0..100 => NullPrecipitationInfo.new() }),
                  record_temp=nil)
    @temperature_range = month.temp_range(dieroller, record_temp)
    @sky_conditions = month.sky_conditions(dieroller)
    @record_temp = record_temp
    @precipitation = precipitation_occurance_chart.type(month.has_precipitation(dieroller) ? dieroller : NullDieRoller.new())
    @wind = Wind.new(dieroller)
  end
  
  def inspect
    "#{@record_temp} #{@temperature_range} #{@sky_conditions} #{@precipitation} #{@wind}"
  end
end
