require 'test/unit'

require 'singledayweather'
require 'month'

require 'rollers/avgroller'
require 'rollers/riggedroller'

class TestWeather < Test::Unit::TestCase
  def test_temp_range_is_calcuated_by_appropriate_die_rolls
    assert_equal(5..24, SingleDayWeather.new(create_month, AvgRoller.new).temperature_range)
  end
  
  def test_determines_sky_conditions
    assert_equal(:partly_cloudy, SingleDayWeather.new(create_month, AvgRoller.new).sky_conditions)
    assert_equal(:clear, SingleDayWeather.new(create_month, RiggedRoller.new(14)).sky_conditions)
  end
  
  def test_determines_precipitation
    assert_equal("precip", 
                 SingleDayWeather.new(create_month, RiggedRoller.new(10), 
                             PrecipitationOccurance.new({ 0..100 => PrecipitationInfo.new("precip")})).
                   precipitation[0].name)
    assert_equal(NullPrecipitationInfo.new().name, 
                 SingleDayWeather.new(create_month, RiggedRoller.new(70),
                             PrecipitationOccurance.new({ 0..100 => PrecipitationInfo.new("precip")})).
                 precipitation[0].name)
  end
  
  def test_deals_with_record_highs
    assert_equal(24..36, SingleDayWeather.new(create_month, RiggedRoller.new(1),
                                    PrecipitationOccurance.new(),
                                    :high).temperature_range)
  end
  
  def test_determines_wind
    assert_equal("9SE", SingleDayWeather.new(create_month, AvgRoller.new).wind.to_s)
  end
  
  def test_checks_for_temp_ranges_on_weather
    assert_equal(NullPrecipitationInfo.new().name, 
                 SingleDayWeather.new(create_month, RiggedRoller.new(10),
                             PrecipitationOccurance.new({ 0..100 => PrecipitationInfo.create_from_data({ :name => "precip",
                                                                                                         :min_temp => 100})})).
                                      precipitation[0].name)
  end
  
  def test_checks_for_terrain_on_precipitation
    assert_equal(NullPrecipitationInfo.new().name, 
                 SingleDayWeather.new(create_month, RiggedRoller.new(10),
                             PrecipitationOccurance.new({ 0..100 => 
                                                          PrecipitationInfo.create_from_data({ :name => "precip",
                                                                                               :not_allowed_in => [:desert]})}), nil, :desert).
                 precipitation[0].name)
  end
  
  private
  def create_month
    Month.new(TemperatureRange.new(13, [10,6], [8,4]), SkyConditions.new((01..23), (24..50), (51..100)), 50)
  end
end
