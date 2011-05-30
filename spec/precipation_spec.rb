require 'spec_helper'
require 'precipitation'
require 'precipitationinfo'

describe Precipitation do
  it "has rainbow" do
    precip = Precipitation.new(PrecipitationInfo.create_from_data({:name => "foo", :chance_of_rainbow => 30}),
                                rigged_roller_mock(10))
    precip.rainbow?.should be_true
  end

  it "has no rainbow" do
    precip = Precipitation.new(PrecipitationInfo.create_from_data({:name => "foo", :chance_of_rainbow => 30}),
                                rigged_roller_mock(40))
    precip.rainbow?.should be_false
  end

  it "has no rainbow if there is no chance of rainbow" do
    precip = Precipitation.new(PrecipitationInfo.create_from_data({ :name => "foo", :chance_of_rainbow => 0}),
                               rigged_roller_mock(0))
    precip.rainbow?.should be_false
  end
end
