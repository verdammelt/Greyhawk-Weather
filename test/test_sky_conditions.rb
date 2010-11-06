require 'test/unit'

require 'skyconditions'

class TestSkyConditions < Test::Unit::TestCase
  def test_pick_from_ranges
    conditions = SkyConditions.new((01..23), (24..50), (51..100))
    assert_equal(:clear, conditions.condition(01))
    assert_equal(:clear, conditions.condition(23))
    assert_equal(:partly_cloudy, conditions.condition(24))
    assert_equal(:partly_cloudy, conditions.condition(50))
    assert_equal(:cloudy, conditions.condition(51))
    assert_equal(:cloudy, conditions.condition(99))
    assert_equal(:cloudy, conditions.condition(100))
  end
  
  def test_zero_equals_hundred
    conditions = SkyConditions.new((01..23), (24..50), (51..100))
    assert_equal(:cloudy, conditions.condition(0))
  end
end
