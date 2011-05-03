require 'wind'

describe Wind do
  it "does default calculation" do
    roller = mock(:DieRoller)
    roller.stub(:roll) { |n, m = 0| n/2 + m }
    Wind.new(roller).to_s.should == "9SE"
  end
end
