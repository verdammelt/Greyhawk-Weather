require 'greyhawkweathergenerator'
require 'avgdieroller'

class TestAcceptanceTests < Test::Unit::TestCase
  def test_generate_weather_for_first_of_planting
    weather = GreyhawkWeatherGenerator.new.generate(1, 4, AvgDieRoller.new)
    assert_equal(weather.base_temperature, 52, "Base Temperature for Planting expected to be 52")
    assert_equal(weather.temperature_range, 44..63)
  end

  def test_generate_weather_for_fifth_of_goodmonth
    weather = GreyhawkWeatherGenerator.new.generate(5, 8, AvgDieRoller.new)
    assert_equal(weather.base_temperature, 75, "Base Temperature for GoodMonth expected to be 75")
    assert_equal(weather.temperature_range, 66..83)
  end
end
