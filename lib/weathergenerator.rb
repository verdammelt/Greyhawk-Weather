require 'singledayweather'

class WeatherGenerator
  attr_reader :days

  def initialize (baselinedata, precipitation_occurance_chart, month_index, num_days, dieroller)
    @days = Array.new

    while num_days > 0
      if (num_days > 28)
        28.times { @days.push make_weather(baselinedata.month(month_index), dieroller, precipitation_occurance_chart) }
        num_days -= 28
        month_index += 1
        if month_index > baselinedata.num_months
          month_index = 1
        end
      else
        num_days.times { @days.push make_weather(baselinedata.month(month_index), dieroller, precipitation_occurance_chart) }
        num_days = 0
      end
    end
  end
  
  private
  def make_weather(month, dieroller, precipitation_occurance_chart)
    SingleDayWeather.new(month, dieroller, precipitation_occurance_chart, check_record_high_low(dieroller))
  end
  
  def check_record_high_low(dieroller)
    record_high_low_range = RangeHash.new({ 1 => [:low, :low, :low],
                                          2 => [:low, :low],
                                          3..4 => :low,
                                          97..98 => :high,
                                          99 => [:high, :high],
                                          100 => [:high, :high, :high]},
                                          :normal)
    record_high_low_range[dieroller.roll(100)]
  end
end
