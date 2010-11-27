require 'test/unit'

require 'precipitationinfo'
require 'precipitation'

require 'rollers/riggedroller'

class TestPrecipitation < Test::Unit::TestCase
  def test_has_rainbow
    precip = Precipitation.new(PrecipitationInfo.create_from_data({ :name => "foo", :chance_of_rainbow => 30}),
                               RiggedRoller.new(10))
    assert_equal(true, precip.rainbow?)
  end

  def test_no_rainbow
    precip = Precipitation.new(PrecipitationInfo.create_from_data({ :name => "foo", :chance_of_rainbow => 30}),
                               RiggedRoller.new(40))
    assert_equal(false, precip.rainbow?)
  end
  
  def test_no_rainbow_if_no_chance_of_it
    precip = Precipitation.new(PrecipitationInfo.create_from_data({ :name => "foo", :chance_of_rainbow => 0}),
                               RiggedRoller.new(0))
    assert_equal(false, precip.rainbow?)
  end
end
