require 'singledayweather'

describe SingleDayWeather do
  it "temp range is calculated by appropriate die rolls" do
    roller = mock(:DieRoller)
    roller.stub(:roll).and_return(0)
    month = mock(:Month).as_null_object
    month.should_recieve(:temp_range).with(roller, nil)
    month.stub(:temp_range).and_return((5..24))
    SingleDayWeather.new(month, roller).temperature_range.should == (5..24)
  end

  it "determines sky conditions" do
    roller = mock(:DieRoller)
    roller.stub(:roll).and_return(50)
    month = mock(:Month).as_null_object
    month.stub(:sky_conditions).and_return(:partly_cloudy)
    SingleDayWeather.new(month, roller).sky_conditions.should == :partly_cloudy
  end

  it "determines precipitation" do
    roller = mock(:DieRoller)
    roller.stub(:roll).and_return(0)

    month = mock(:Month).as_null_object

    precip = mock(:PrecipitationInfo)

    precipitation = mock(:PrecipitationOccurance).as_null_object
    precipitation.should_recieve(:type).with(roller, month, anything())
    precipitation.stub(:type).and_return([precip])
    SingleDayWeather.new(month, roller, precipitation).precipitation[0].should == precip
  end

  it "deals with record highs" do
    roller = mock(:DieRoler)
    roller.stub(:roll).and_return(0)
    month = mock(:Month).as_null_object
    month.should_recieve(:temp_range).with(anything(), anything(), :high)
    SingleDayWeather.new(month, roller, mock(:PrecipitationOccurance).as_null_object, :high)
  end

  it "determines wind" do
    roller = mock(:DieRoller)
    roller.stub(:roll){|n, m| n/2+(m||0)}
    SingleDayWeather.new(mock(:Month).as_null_object, roller).wind.to_s.should == "9SE"
  end
end 
