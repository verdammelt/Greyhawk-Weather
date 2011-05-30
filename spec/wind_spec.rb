require 'spec_helper'
require 'wind'

describe Wind do
  it "does default calculation" do
    Wind.new(avg_roller_mock).to_s.should == "9SE"
  end
end
