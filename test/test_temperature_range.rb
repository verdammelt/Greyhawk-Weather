require 'test/unit'

require 'rollers/avgroller'

require 'temperaturerange'

class TestTemperaratureRange < Test::Unit::TestCase
  def test_uses_die_roller_for_range_construction 
    temp = TemperatureRange.new(10, [8, 4], [10, 4])
    assert_equal((1..18), temp.range(AvgRoller.new))
  end
  
  def test_handles_record_high
    temp = TemperatureRange.new(10, [8, 2], [8, 2])
    assert_equal(14..26, temp.range(AvgRoller.new, :high))
    assert_equal(24..36, temp.range(AvgRoller.new, [:high,:high]))
  end
  
  def test_handles_record_low
    temp = TemperatureRange.new(10, [8, 2], [8, 2])
    assert_equal(-6..6, temp.range(AvgRoller.new, :low))
    assert_equal(-16..-4, temp.range(AvgRoller.new, [:low,:low]))
  end
  
  def test_handles_mix_of_records
    temp = TemperatureRange.new(10, [8, 2], [8, 2])
    assert_equal(4..16, temp.range(AvgRoller.new, [:high,:low]))
    assert_equal(14..26, temp.range(AvgRoller.new, [:high,:low,:high]))
  end
end
