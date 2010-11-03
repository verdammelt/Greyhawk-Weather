require 'test/unit'

require 'weather'

require 'avgdieroller'

class RiggedDieRoller < DieRoller
  def initialize(roll)
    @roll = roll
  end

  def roll(nsides, modifier=0)
    @roll + modifier
  end
end

class TestWeather < Test::Unit::TestCase
  def test_base_temp_is_simply_base_temp_of_month
    assert_equal(Weather.new(create_month, AvgDieRoller.new).base_temperature, 13)
  end
  
  def test_temp_range_is_calcuated_by_appropriate_die_rolls
    assert_equal(Weather.new(create_month, AvgDieRoller.new).temperature_range, 5..24)
  end
  
  def test_determines_sky_conditions
    assert_equal(Weather.new(create_month, AvgDieRoller.new).sky_conditions, :partly_cloudy)
    assert_equal(Weather.new(create_month, RiggedDieRoller.new(14)).sky_conditions, :clear)
  end

  private
  def create_month
    Month.new(13, {:high => [10, 6], :low => [8, 4]}, SkyConditions.new((01..23), (24..50), (51..100)))
  end
end
