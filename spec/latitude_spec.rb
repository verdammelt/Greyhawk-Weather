require 'spec_helper'
require 'singledayweather'
require 'util/dieroller'

describe "Base temperature modified by latitude" do
  it "should increase base temp by 2 degrees Farenheit for each degree latitude below 40" do
    month = mock(:Month).as_null_object
    month.stub(:temp_range).and_return((10..20))
    roller = mock(:DieRoller)
    roller.stub(:roll).and_return(10)
    weather = SingleDayWeather.new(month, roller, PrecipitationOccurance.new, nil, :plains, 30)
    weather.temperature_range.should == (-10..0)
  end

  it "should decrease base temp by 2 degrees Farenheit for each degree latitude above 40" do
    month = mock(:Month).as_null_object
    month.stub(:temp_range).and_return((10..20))
    roller = mock(:DieRoller)
    roller.stub(:roll).and_return(10)
    weather = SingleDayWeather.new(month, roller, PrecipitationOccurance.new, nil, :plains, 50)
    weather.temperature_range.should == (30..40)
  end
end
