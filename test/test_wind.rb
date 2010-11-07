require 'test/unit'

require 'rollers/avgroller'

require 'wind'

class TestWind < Test::Unit::TestCase
  def test_default_wind_calculation
    assert_equal("9SE", Wind.new(AvgRoller.new).to_s)
  end
end
