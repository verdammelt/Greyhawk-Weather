require 'weather'

class WeatherGenerator
  attr_reader :days

  def initialize (baselinedata, month, num_days, dieroller)
    @baselinedata = baselinedata
    @month = month
    @num_days = num_days
    @dieroller = dieroller

    @days = Array.new

    while @num_days > 0
      if (@num_days > 28)
        28.times { @days.push Weather.new(@baselinedata.month(@month), @dieroller) }
        @num_days -= 28
        @month += 1
        if @month > baselinedata.num_months
          @month = 1
        end
      else
        @num_days.times { @days.push Weather.new(@baselinedata.month(@month), @dieroller) }
        @num_days = 0
      end
    end
  end
end
