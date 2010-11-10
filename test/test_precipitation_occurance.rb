require 'test/unit'

require 'rollers/riggedroller'

require 'precipitationoccurance'
require 'precipitationinfo'

class TestPrecipitationOccurance < Test::Unit::TestCase
  def test_determines_precipitation
    precip_occur = PrecipitationOccurance.new({ (0..20) => PrecipitationInfo.create_from_data({ :name => :light_snowstorm}),
                                                (21..100) => PrecipitationInfo.create_from_data({ :name => :light_rainstorm})})
    assert_equal(:light_snowstorm, precip_occur.type(RiggedRoller.new(13)).name)
    assert_equal(:light_rainstorm, precip_occur.type(RiggedRoller.new(57)).name)
  end
  
  def test_load_from_file
    precip_occur = PrecipitationOccurance.load("data/precipitationoccurance.yml")
    assert_equal("Snowstorm, light", precip_occur.type(RiggedRoller.new(13)).name)
  end
end
