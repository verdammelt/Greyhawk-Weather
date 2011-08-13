require 'spec_helper'
require 'singledayweather'

describe SingleDayWeather do
  it "temp range is calculated by appropriate die rolls" do
    roller = rigged_roller_mock 0
    month = mock(:Month).as_null_object
    month.should_recieve(:temp_range).with(roller, nil)
    month.stub(:temp_range).and_return((5..24))
    SingleDayWeather.new(month, roller).temperature_range.should == (5..24)
  end

  it "determines sky conditions" do
    roller = rigged_roller_mock 50
    month = mock(:Month).as_null_object
    month.stub(:sky_conditions).and_return(:partly_cloudy)
    SingleDayWeather.new(month, roller).sky_conditions.should == :partly_cloudy
  end

  it "determines precipitation" do
    roller = rigged_roller_mock 0

    month = mock(:Month).as_null_object

    precip = mock(:PrecipitationInfo)

    precipitation = mock(:PrecipitationOccurance).as_null_object
    precipitation.should_receive(:type).with(roller, anything(), anything()).and_return([precip])
    SingleDayWeather.new(month, roller, precipitation).precipitation.should == [precip]
  end

  it "deals with record highs" do
    roller = rigged_roller_mock 0
    month = mock(:Month).as_null_object
    month.should_recieve(:temp_range).with(anything(), anything(), :high)
    precip_occur =  mock(:PrecipitationOccurance).as_null_object
    precip_occur.stub(:type)
    SingleDayWeather.new(month, roller, precip_occur, :high)
  end

  it "determines wind" do
    SingleDayWeather.new(mock(:Month).as_null_object, avg_roller_mock).wind.to_s.should == "9SE"
  end
end 
