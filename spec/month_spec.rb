require 'spec_helper'
require 'month'

describe Month do
  it "uses sky condition data to determine current conditions" do
    month = Month.new(nil, SkyConditions.new((0..34), (35..65), (66..100)))
    month.sky_conditions(make_roller(25)).should eq(:clear)
    month.sky_conditions(make_roller(50)).should eq(:partly_cloudy)
    month.sky_conditions(make_roller(75)).should eq(:cloudy)
  end

  it "uses temp range data to determine current conditions" do
    month = Month.new(TemperatureRange.new(10, [8, 2], [20, 5]), nil)
    month.temp_range(make_roller(5)).should == (0..17)
  end

  it "handles record high" do
    month = Month.new(TemperatureRange.new(10, [8, 2], [20, 5]), nil)
    month.temp_range(make_roller(1), :high).should == (14..23)
  end

  it "determines precipitation" do
    month = Month.new(nil, nil, 50)
    month.has_precipitation(make_roller(10)).should be_true
    month.has_precipitation(make_roller(70)).should be_false
  end

  private
  def make_roller(roll)
    roller = mock(:DieRoller)
    roller.stub(:roll) { |n, m| roll + (m || 0)}
    roller
  end
end 
