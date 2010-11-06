require 'test/unit'

require 'dieroller'

$next_defined_random_number = 0
$max_arg_to_rand = -1

def rand (max=0)
  $max_arg_to_rand = max
  $next_defined_random_number
end

class TestDieRoller < Test::Unit::TestCase
  def test_D6
    $next_defined_random_number = 3
    assert_equal(DieRoller.new.roll(6), 4, "should return random number (+1)")
    assert_equal($max_arg_to_rand, 6, "should have defined 6 as maximum number to rand")
  end
  
  def test_is_1_to_N_range
    $next_defined_random_number = 0
    assert_equal(DieRoller.new.roll(6), 1, "should use 1..N range")
  end

  def test_applies_modifier_if_given
    $next_defined_random_number = 1
    assert_equal(DieRoller.new.roll(6, +2), 4, "Should have added the +2")
    assert_equal(DieRoller.new.roll(6, -3), -1, "Should have added the -3")
  end
end
