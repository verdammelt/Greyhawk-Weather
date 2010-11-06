require 'test/unit'

require 'weather'
require 'month'

require 'rollers/avgroller'
require 'rollers/riggedroller'

class TestWeather < Test::Unit::TestCase
  def test_temp_range_is_calcuated_by_appropriate_die_rolls
    assert_equal(5..24, Weather.new(create_month, AvgRoller.new).temperature_range)
  end
  
  def test_determines_sky_conditions
    assert_equal(:partly_cloudy, Weather.new(create_month, AvgRoller.new).sky_conditions)
    assert_equal(:clear, Weather.new(create_month, RiggedRoller.new(14)).sky_conditions)
  end
  
  def test_determines_precipitation
    assert_not_nil(true, Weather.new(create_month, RiggedRoller.new(10)).precipitation)
    assert_nil(Weather.new(create_month, RiggedRoller.new(70)).precipitation)
  end
  
  private
  def create_month
    Month.new(TemperatureRange.new(13, [10,6], [8,4]), SkyConditions.new((01..23), (24..50), (51..100)), 50)
  end
end
