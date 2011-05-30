require 'spec_helper'
require 'singledayweather'
require 'util/dieroller'

describe "Base temperature modified by latitude" do
  let(:month) {
    month = mock(:Month).as_null_object
    month.stub(:temp_range).and_return((10..20))
    month
  }

  let(:roller) {
    rigged_roller_mock 10
  }

  it "should increase base temp by 2 degrees Farenheit for each degree latitude below 40" do
    weather = SingleDayWeather.new(month, roller, PrecipitationOccurance.new, nil, :plains, 30)
    weather.temperature_range.should == (-10..0)
  end

  it "should decrease base temp by 2 degrees Farenheit for each degree latitude above 40" do
    weather = SingleDayWeather.new(month, roller, PrecipitationOccurance.new, nil, :plains, 50)
    weather.temperature_range.should == (30..40)
  end
end
