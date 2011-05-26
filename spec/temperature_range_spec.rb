require 'spec_helper'
require 'temperaturerange'

describe "TemperatureRange" do
  let(:roller) do
    roller = mock(:DieRoller)
    roller.stub(:roll) {|n, m|  n/2 + (m||0)}
    roller
  end

  subject {TemperatureRange.new(10, [8, 2], [8, 2])}

  it "uses die roller for range construction" do
    subject.range(roller).should == (4..16)
  end

  it "handles record high" do
    subject.range(roller, :high).should == (14..26)
    subject.range(roller, [:high, :high]).should == (24..36)
  end

  it "handles record low" do
    subject.range(roller, :low).should == (-6..6)
    subject.range(roller, [:low, :low]).should == (-16..-4)
  end

  it "handles a mix of records" do
    subject.range(roller, [:high, :low]).should == (4..16)
    subject.range(roller, [:high, :low, :high]).should == (14..26)
  end
end
