require 'test/unit'

require 'skyconditions'

class TestSkyConditions < Test::Unit::TestCase
  def test_pick_from_ranges
    conditions = SkyConditions.new((01..23), (24..50), (51..100))
    assert_equal(conditions.condition(01), :clear)
    assert_equal(conditions.condition(23), :clear)
    assert_equal(conditions.condition(24), :partly_cloudy)
    assert_equal(conditions.condition(50), :partly_cloudy)
    assert_equal(conditions.condition(51), :cloudy)
    assert_equal(conditions.condition(99), :cloudy)
    assert_equal(conditions.condition(100), :cloudy)
  end
  
  def test_zero_equals_hundred
    conditions = SkyConditions.new((01..23), (24..50), (51..100))
    assert_equal(conditions.condition(0), :cloudy)
  end
end
