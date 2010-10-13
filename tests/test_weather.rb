require 'weather'

require 'avgdieroller'


class TestWeather < Test::Unit::TestCase
  def test_base_temp_is_simply_base_temp_of_month
    assert_equal(Weather.new(create_month, AvgDieRoller.new).base_temperature, 13)
  end
  
  def test_temp_range_is_calcuated_by_appropriate_die_rolls
    assert_equal(Weather.new(create_month, AvgDieRoller.new).temperature_range, 5..24)
  end

  private
  def create_month
    Month.new(13, {:high => [10, 6], :low => [8, 4]})
  end
end
