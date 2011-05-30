require 'singledayweather'

class WeatherGenerator
  attr_reader :days

  def initialize (baselinedata, precipitation_occurance_chart, options)
    month_for_each_day = make_months_for_days_array(baselinedata, options.month, options.num_days)
    @days = month_for_each_day.map do |month|
      make_weather month, options.dieroller, precipitation_occurance_chart, options.terrain
    end
  end
  
  private
  def make_months_for_days_array(baselinedata, month_index, num_days)
    months = Array.new
    while num_days > 0
      if (num_days > 28)
        28.times { months.push baselinedata.month(month_index) }
        num_days -= 28
        month_index += 1
        if month_index > baselinedata.num_months
          month_index = 1
        end
      else
        num_days.times { months.push baselinedata.month(month_index) }
        num_days = 0
      end
    end
    months
  end

  def make_weather(month, dieroller, precipitation_occurance_chart, terrain)
    SingleDayWeather.new(month, dieroller, precipitation_occurance_chart, check_record_high_low(dieroller), terrain)
  end
  
  RECORD_HIGH_LOW_RANGES = {
    1 => [:low, :low, :low],
    2 => [:low, :low],
    3..4 => :low,
    97..98 => :high,
    99 => [:high, :high],
    100 => [:high, :high, :high]
  }

  def check_record_high_low(dieroller)
    record_high_low_range = RangeHash.new(:normal)
    record_high_low_range.merge!(RECORD_HIGH_LOW_RANGES)
    record_high_low_range[dieroller.roll(100)]
  end
end
