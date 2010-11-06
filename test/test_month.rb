require 'test/unit'

require 'rollers/riggedroller'

require 'month'

class TestMonth < Test::Unit::TestCase

  def setup
    @null_temp_range = TemperatureRange.new(0, [0, 0], [0, 0])
    @null_sky_conditions = SkyConditions.new((0..0), (0..0), (0..0))
  end
  
  def test_uses_sky_condition_data_to_determine_current_conditions
    month = Month.new(@null_temp_range, SkyConditions.new((0..34), (35..65), (66..100)))
    assert_equal(month.sky_conditions(RiggedRoller.new(25)), :clear)
    assert_equal(month.sky_conditions(RiggedRoller.new(50)), :partly_cloudy)
    assert_equal(month.sky_conditions(RiggedRoller.new(75)), :cloudy)
  end
  
  def test_uses_temp_range_data_to_determine_current_conditions
    month = Month.new(TemperatureRange.new(10, [8, 2], [20, 5]), @null_sky_conditions)
    assert_equal(month.temp_range(RiggedRoller.new(5)), (0..17))
  end
  
  def test_determines_precipitation
    month = Month.new(@null_temp_range, @null_sky_conditions, 50)
    assert_equal(month.precipitation(RiggedRoller.new(10)), true)
    assert_equal(month.precipitation(RiggedRoller.new(70)), false)
  end
end
