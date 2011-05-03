require 'precipitation'
require 'precipitationinfo'

describe Precipitation do
  it "has rainbow" do
    precip = Precipitation.new(PrecipitationInfo.create_from_data({:name => "foo", :chance_of_rainbow => 30}),
                                mock_roller(10))
    precip.rainbow?.should be_true
  end

  it "has no rainbow" do
    precip = Precipitation.new(PrecipitationInfo.create_from_data({:name => "foo", :chance_of_rainbow => 30}),
                                mock_roller(40))
    precip.rainbow?.should be_false
  end

  it "has no rainbow if there is no chance of rainbow" do
    precip = Precipitation.new(PrecipitationInfo.create_from_data({ :name => "foo", :chance_of_rainbow => 0}),
                               mock_roller(0))
    precip.rainbow?.should be_false
  end

  def mock_roller(n)
    roller = mock(:DieRoller)
    roller.stub(:roll).and_return n
    roller
  end
end
