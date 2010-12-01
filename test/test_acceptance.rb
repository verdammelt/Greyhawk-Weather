require 'test/unit'

require 'rollers/avgroller'
require 'rollers/riggedroller'

require 'greyhawkweathergenerator'

class TestAcceptanceTests < Test::Unit::TestCase
  def test_generate_weather_for_three_days_in_planting
    weather_generator = GreyhawkWeatherGenerator.create_weather_generator(4, 3, AvgRoller.new)
    assert_equal(3, weather_generator.days.length, "should have generated 3 days")
  end

  def test_generate_weather_for_planting
    weather_generator = GreyhawkWeatherGenerator.create_weather_generator(4, 1, AvgRoller.new)
    weather = weather_generator.days[0]
    assert_equal(44..63, weather.temperature_range)
    assert_equal(:partly_cloudy, weather.sky_conditions)
    assert_equal(NullPrecipitationInfo.new().name, weather.precipitation[0].name)
  end

  def test_generate_weather_for_goodmonth
    weather_generator = GreyhawkWeatherGenerator.create_weather_generator(8, 1, AvgRoller.new)
    weather = weather_generator.days[0]
    assert_equal(66..83, weather.temperature_range)
    assert_equal(:partly_cloudy, weather.sky_conditions)
    assert_equal(NullPrecipitationInfo.new().name, weather.precipitation[0].name)
  end
  
  def test_generate_weather_with_terrain
    weather_generator = GreyhawkWeatherGenerator.create_weather_generator(1, 1, RiggedRoller.new(30), :desert)
    weather = weather_generator.days[0]
    # without terrain the above would generate "Fog, Heavy" for precipitation
    assert_equal(NullPrecipitationInfo.new().name, weather.precipitation[0].name)
  end
end
