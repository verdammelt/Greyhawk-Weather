require 'test/unit'

require 'rollers/riggedroller'

require 'precipitationoccurance'
require 'precipitationinfo'

class TestPrecipitationOccurance < Test::Unit::TestCase
  def test_returns_array_of_precipitation
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :light_snowstorm}),
                                                (21..100) => create_precip_info({ :name => :light_rainstorm})})
    assert_instance_of(Array, precip_occur.type(RiggedRoller.new(13)))
    assert_instance_of(Precipitation, precip_occur.type(RiggedRoller.new(13))[0])
  end

  def test_determines_precipitation
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :light_snowstorm}),
                                                (21..100) => create_precip_info({ :name => :light_rainstorm})})
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
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :light_snowstorm, :chance_to_continue => 10}),
                                                (21..100) => create_precip_info({ :name => :light_rainstorm, :chance_to_continue => 10})})
    assert_equal([:light_rainstorm, :light_snowstorm, :light_rainstorm, :light_rainstorm],
                 precip_occur.type(RiggedRoller.new(35, 5, 1, 5, 10, 5, 5, 100)).map{ |p| p.name })
  end
  
  def test_no_reroll_if_temp_range_is_ok
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :cold, :min_temp => 0}),
                                                (21..100) => create_precip_info({ :name => :warm, :min_temp => 30})})
    assert_equal([:warm], precip_occur.type(RiggedRoller.new(35, 10), 40..50).map{ |p| p.name })
  end

  def test_reroll_if_temp_is_too_low
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :cold, :min_temp => 0}),
                                                (21..100) => create_precip_info({ :name => :warm, :min_temp => 30})})
    assert_equal(:cold, precip_occur.type(RiggedRoller.new(35, 10), 10..20)[0].name)
  end
  
  def test_reroll_if_temp_is_too_high
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :cold, :max_temp => 30}),
                                                (21..100) => create_precip_info({ :name => :warm, :max_temp => 50})})
    assert_equal(:warm, precip_occur.type(RiggedRoller.new(10, 35), 40..60)[0].name)
  end

  def test_rerolls_once_only_for_bad_weather
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :cold, :max_temp => 30})})
    assert_equal(Precipitation.new(NullPrecipitationInfo.new(), nil).name,
                 precip_occur.type(RiggedRoller.new(10, 10), 60..70)[0].name)
  end
  
  def test_checks_temp_ranges_for_continuing_weather
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :cold, 
                                                                                :chance_to_continue  => 10,
                                                                                :max_temp => 20}),
                                                (21..100) => create_precip_info({ :name => :hot, 
                                                                                  :chance_to_continue => 10,
                                                                                  :min_temp => 40})})
    assert_equal([:hot, :hot],
                 precip_occur.type(RiggedRoller.new(35, 5, 1, 20), 30..50).map{ |p| p.name })
  end
  
  def test_checks_terrain_for_precipitation
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :not, :not_allowed_in => [:desert]})})
    assert_equal(NullPrecipitationInfo.new().name, precip_occur.type(RiggedRoller.new(10), nil, :desert).first.name)
  end

  def test_checks_terrain_for_continuin_weather
    precip_occur = PrecipitationOccurance.new({ (0..20) => create_precip_info({ :name => :cold, 
                                                                                :chance_to_continue  => 10,
                                                                                :not_allowed_in => [:desert]}),
                                                (21..100) => create_precip_info({ :name => :hot, 
                                                                                  :chance_to_continue => 10 })})
    assert_equal(:hot, precip_occur.type(RiggedRoller.new(35, 5, 1, 20), nil, :desert)[1].name)
  end

  private 
  def create_precip_info(hash)
    PrecipitationInfo.create_from_data(hash)
  end
end
