require 'WeatherGenerator'
require 'BaselineData'
require 'DieRoller'
require 'TemperatureRange'
require 'SkyConditions'
require 'test/unit'
require 'avgdieroller'
require 'riggeddieroller'

class TestBaselineData < BaselineData
  def initialize (all_data)
    @all_data = all_data
  end
end

class IncrementingDieRoller < DieRoller
  def initialize
    @first = 0
  end
  
  def roll(nSides, modifier)
    @first += 1
    @first
  end
end

class TestWeatherGenerator < Test::Unit::TestCase
  def setup
    @testbaseline = TestBaselineData.new [{ :temp_range => TemperatureRange.new(10, [4, 0], [4, 0]),
                                            :sky_conditions => SkyConditions.new((0..0), (0..0), (0..0))},
                                          { :temp_range => TemperatureRange.new(20, [4, 0], [4, 0]),
                                            :sky_conditions => SkyConditions.new((0..0), (0..0), (0..0))}]
  end

  def test_generator_creates_num_days_of_weather
    generator = WeatherGenerator.new @testbaseline, 1, 1, AvgDieRoller.new
    assert_equal(1, generator.days.length, "Should have only generated 1 day of weeather")
    
    generator = WeatherGenerator.new @testbaseline, 1, 13, AvgDieRoller.new
    assert_equal(13, generator.days.length, "Should have generated 13 day of weeather")
  end
  
  def test_actual_days_generated
    generator = WeatherGenerator.new @testbaseline, 1, 3, IncrementingDieRoller.new
    assert_equal([9..12, 6..15, 3..18], generator.days.collect{ |d| d.temperature_range }, 
                 "Each item in days should have calculated temperature range")
  end
  
  def test_days_are_not_regenerated_each_access
    generator = WeatherGenerator.new @testbaseline, 1, 1, IncrementingDieRoller.new
    weather = generator.days[0]
    assert_equal(weather, generator.days[0], "Each access of days should return equal data")
  end
  
  def test_generated_days_cross_month_boundaries
    generator = WeatherGenerator.new @testbaseline, 1, 31, RiggedDieRoller.new(1)
    unique_ranges = generator.days.collect{ |d| d.temperature_range}.uniq
    assert_equal(2, unique_ranges.length, "Not all ranges should be the same")
    assert_equal(28, generator.days.select{ |d| d.temperature_range == (9..11) }.length, "should have 28 items from the first month")
    assert_equal(3, generator.days.select{ |d| d.temperature_range == (19..21)}.length, "Should have 3 items from the first month")
  end
  
  def test_months_wrap_around_if_past_end_of_year
    generator = WeatherGenerator.new @testbaseline, 2, 29, RiggedDieRoller.new(1)
    assert_equal((9..11), generator.days.last.temperature_range, "Last one should be first month")
  end
end
