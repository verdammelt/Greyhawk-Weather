require 'test/unit'

require 'rollers/riggedroller'

require 'skyconditions'

class TestSkyConditions < Test::Unit::TestCase
  def test_pick_from_ranges
    conditions = SkyConditions.new((01..23), (24..50), (51..100))
    assert_equal(:clear, conditions.condition(RiggedRoller.new(01)))
    assert_equal(:clear, conditions.condition(RiggedRoller.new(23)))
    assert_equal(:partly_cloudy, conditions.condition(RiggedRoller.new(24)))
    assert_equal(:partly_cloudy, conditions.condition(RiggedRoller.new(50)))
    assert_equal(:cloudy, conditions.condition(RiggedRoller.new(51)))
    assert_equal(:cloudy, conditions.condition(RiggedRoller.new(99)))
    assert_equal(:cloudy, conditions.condition(RiggedRoller.new(100)))
  end
  
  def test_zero_equals_hundred
    conditions = SkyConditions.new((01..23), (24..50), (51..100))
    assert_equal(:cloudy, conditions.condition(RiggedRoller.new(0)))
  end
end
