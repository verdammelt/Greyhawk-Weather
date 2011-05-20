require 'wind'

describe Wind do
  it "does default calculation" do
    roller = mock(:DieRoller)
    roller.stub(:roll) { |n, m| n/2 + (m||0) }
    Wind.new(roller).to_s.should == "9SE"
  end
end
