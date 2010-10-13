require 'greyhawkweathergenerator'

class TestAcceptanceTests < Test::Unit::TestCase
  def test_generate_weather_for_first_of_planting
    weather = GreyhawkWeatherGenerator.new.generate(1, 4)
    assert_equal(weather.base_temperature, 52, "Base Temperature for Planting expected to be 52")
    # assert_equal(weather.temperature_range, [46..63])
  end

  def test_generate_weather_for_fifth_of_goodmonth
    weather = GreyhawkWeatherGenerator.new.generate(5, 8)
    assert_equal(weather.base_temperature, 75, "Base Temperature for GoddMonth expected to be 75")
  end
end
