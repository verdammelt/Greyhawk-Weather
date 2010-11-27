require 'test/unit'

require 'rollers/riggedroller'

require 'precipitationoccurance'
require 'precipitationinfo'

class TestPrecipitationOccurance < Test::Unit::TestCase
  def test_returns_array_of_precipitation
    precip_occur = PrecipitationOccurance.new({ (0..20) => PrecipitationInfo.create_from_data({ :name => :light_snowstorm}),
                                                (21..100) => PrecipitationInfo.create_from_data({ :name => :light_rainstorm})})
    assert_instance_of(Array, precip_occur.type(RiggedRoller.new(13)))
    assert_instance_of(Precipitation, precip_occur.type(RiggedRoller.new(13))[0])
  end

  def test_determines_precipitation
    precip_occur = PrecipitationOccurance.new({ (0..20) => PrecipitationInfo.create_from_data({ :name => :light_snowstorm}),
                                                (21..100) => PrecipitationInfo.create_from_data({ :name => :light_rainstorm})})
    assert_equal(:light_snowstorm, precip_occur.type(RiggedRoller.new(13))[0].name)
    assert_equal(:light_rainstorm, precip_occur.type(RiggedRoller.new(57))[0].name)
  end
  
  def test_load_from_file
    precip_occur = PrecipitationOccurance.load("data/precipitationoccurance.yml")
    assert_equal("Sleetstorm", precip_occur.type(RiggedRoller.new(22))[0].name)
  end
  
  def test_default_value_is_null_precipitation
    precip_occur = PrecipitationOccurance.new()
    assert_equal(NullPrecipitationInfo.new().name, precip_occur.type(RiggedRoller.new(13))[0].name)
  end
  
  def test_checks_for_and_computes_continuing_precipitation
    precip_occur = PrecipitationOccurance.new({ (0..20) => PrecipitationInfo.create_from_data({ :name => :light_snowstorm,
                                                                                              :chance_to_continue => 10}),
                                                (21..100) => PrecipitationInfo.create_from_data({ :name => :light_rainstorm,
                                                                                                  :chance_to_continue => 10})})
    assert_equal([:light_rainstorm, :light_snowstorm, :light_rainstorm, :light_rainstorm],
                 precip_occur.type(RiggedRoller.new(35, 5, 1, 5, 10, 5, 5, 100)).map{ |p| p.name })
  end
end
