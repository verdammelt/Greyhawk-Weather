require 'weather'

class WeatherGenerator
  attr_reader :days

  def initialize (baselinedata, month, num_days, dieroller)
    @baselinedata = baselinedata
    @month = month
    @num_days = num_days
    @dieroller = dieroller
    @days = Array.new @num_days
    @days.collect! { Weather.new(@baselinedata.month(@month), @dieroller) }
  end
end
