require 'greyhawkweathergenerator'
require 'avgdieroller'

class TestAcceptanceTests < Test::Unit::TestCase
  def test_generate_weather_for_planting
    weather_generator = GreyhawkWeatherGenerator.new.create_weather_generator(4, 1, AvgDieRoller.new)
    weather = weather_generator.days[0]
    assert_equal(weather.base_temperature, 52, "Base Temperature for Planting expected to be 52")
    assert_equal(weather.temperature_range, 44..63)
  end

  def ignore_test_generate_weather_for_three_days_in_planting
    weather_generator = GreyhawkWeatherGenerator.new.create_weather_generator(4, 3, AvgDieRoller.new)
    assert_equal(3, weather_generator.days.length, "should have generated 3 days")
  end

  def test_generate_weather_for_goodmonth
    weather_generator = GreyhawkWeatherGenerator.new.create_weather_generator(8, 1, AvgDieRoller.new)
    weather = weather_generator.days[0]
    assert_equal(weather.base_temperature, 75, "Base Temperature for GoodMonth expected to be 75")
    assert_equal(weather.temperature_range, 66..83)
  end
end
