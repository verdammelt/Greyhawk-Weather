require 'test/unit'

require 'rollers/avgroller'

require 'temperaturerange'

class TestTemperaratureRange < Test::Unit::TestCase
  def test_uses_die_roller_for_range_construction 
    temp = TemperatureRange.new(10, [8, 4], [10, 4])
    assert_equal((1..18), temp.range(AvgRoller.new))
  end
end
