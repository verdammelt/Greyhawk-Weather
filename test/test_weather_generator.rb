require 'test/unit'

require 'WeatherGenerator'
require 'BaselineData'

require 'rollers/avgroller'
require 'rollers/riggedroller'

class TestBaselineData < BaselineData
  def initialize (all_data)
    @all_data = all_data
  end
end

class TestWeatherGenerator < Test::Unit::TestCase
  def setup
    @testbaseline = TestBaselineData.new [{ :temp_range => TemperatureRange.new(10, [4, 0], [4, 0]),
                                            :sky_conditions => { :clear => (0..0), :partly => (0..0), :cloudy => (0..0) },
                                            :precipitation_chance => 40 },
                                          { :temp_range => TemperatureRange.new(20, [4, 0], [4, 0]),
                                            :sky_conditions => { :clear => (0..0), :partly => (0..0), :cloudy => (0..0) },
                                            :precipitation_chance => 70 }]
    @testprecipchart = PrecipitationOccurance.new({ 0..25 => PrecipitationInfo.new({ :name => "Rain"}),
                                                    26..50 => PrecipitationInfo.new({ :name => "Snow"}),
                                                    51..75 => PrecipitationInfo.new({ :name => "Hail"}),
                                                    76..100 => PrecipitationInfo.new({ :name => "Smog"})})
  end

  def test_generator_creates_num_days_of_weather
    generator = WeatherGenerator.new @testbaseline, @testprecipchart, 1, 1, AvgRoller.new
    assert_equal(1, generator.days.length, "Should have only generated 1 day of weeather")
    
    generator = WeatherGenerator.new @testbaseline, @testprecipchart, 1, 13, AvgRoller.new
    assert_equal(13, generator.days.length, "Should have generated 13 day of weeather")
  end
  
  def test_generated_days_cross_month_boundaries
    generator = WeatherGenerator.new @testbaseline, @testprecipchart, 1, 31, RiggedRoller.new(1)
    unique_ranges = generator.days.collect{ |d| d.temperature_range}.uniq
    assert_equal(2, unique_ranges.length, "Not all ranges should be the same")
    assert_equal(28, generator.days.select{ |d| d.temperature_range == (9..11) }.length, "should have 28 items from the first month")
    assert_equal(3, generator.days.select{ |d| d.temperature_range == (19..21)}.length, "Should have 3 items from the first month")
  end
  
  def test_months_wrap_around_if_past_end_of_year
    generator = WeatherGenerator.new @testbaseline, @testprecipchart, 2, 29, RiggedRoller.new(1)
    assert_equal((9..11), generator.days.last.temperature_range, "Last one should be first month")
  end
end
