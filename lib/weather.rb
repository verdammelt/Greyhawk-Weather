require 'month'

require 'precipitationoccurance'
require 'precipitationinfo'

class Weather
  attr_reader :temperature_range
  attr_reader :sky_conditions
  attr_reader :precipitation
  
  def initialize (month, dieroller, 
                  precipitation_occurance_chart=PrecipitationOccurance.new({ 0..100 => PrecipitationInfo.new({ :name => "None"})}))
    @temperature_range = month.temp_range(dieroller)
    @sky_conditions = month.sky_conditions(dieroller)

    @precipitation = nil
    if month.precipitation(dieroller)
      @precipitation = precipitation_occurance_chart[dieroller.roll(100)]
    end
  end
  
  def inspect
    "#{@sky_conditions} day " +
      "with temp between #{@temperature_range.begin} and #{@temperature_range.end} " +
      "with #{@precipitation ? precipitation.name : "no precipitation"}"
  end
end

