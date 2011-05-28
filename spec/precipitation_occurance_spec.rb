require 'spec_helper'
require 'precipitationoccurance'

describe PrecipitationOccurance do
  it "returns array of precipitation" do
    roller = make_roller(13)
    precip_occur = PrecipitationOccurance.new({(0..20) => mock(:PrecipitationInfo).as_null_object,
                                                (21..100) => mock(:PrecipitationInfo).as_null_object})
    precip_occur.type(roller).should be_instance_of Array
    precip_occur.type(roller)[0].should be_instance_of Precipitation
  end

  it "determines precipitation" do
    snowstorm = create_test_precipitation(:light_snowstorm)
    rainstorm = create_test_precipitation(:light_rainstorm)

    precip_occur = PrecipitationOccurance.new({(0..20) => snowstorm,
                                                (21..100) => rainstorm})
    precip_occur.type(make_roller(13))[0].name.should eq(:light_snowstorm)
    precip_occur.type(make_roller(57))[0].name.should eq(:light_rainstorm)
  end

  it "loads from file" do
    precip_occur = PrecipitationOccurance.load("data/precipitationoccurance.yml")
    precip_occur.type(make_roller(22))[0].name.should == "Sleetstorm"
  end

  it "defaults to null precipitation" do
    PrecipitationOccurance.new.type(make_roller(13))[0].name.should == NullPrecipitationInfo.new.name
  end

  it "checks for and computes continuing precipitation" do
    snowstorm = create_test_precipitation(:light_snowstorm)
    rainstorm = create_test_precipitation(:light_rainstorm)
    precip_occur = PrecipitationOccurance.new({(0..20) => snowstorm,
                                                (21..100) => rainstorm})
    precip_occur.type(make_roller(35, 5, 1, 5, 10, 5, 5, 100)).map{ |p| p.name }.should ==
      [:light_rainstorm, :light_snowstorm, :light_rainstorm, :light_rainstorm]
  end

  it "checks terrain for precipitation" do
    precip = mock(:PrecipitationInfo)
    precip.stub(:not_allowed_in).and_return([:desert])

    precip_occur = PrecipitationOccurance.new({ (0..20) => precip})
    precip_occur.type(make_roller(10), nil, :desert).first.name.should == NullPrecipitationInfo.new.name
  end

  it "does no reroll if temp_range is ok" do
    precip = mock(:PrecipitationInfo)
    precip.stub(:min_temp).and_return(10)
    precip.stub(:max_temp).and_return(50)
    precip.stub(:not_allowed_in).and_return([])
    precip.stub(:name).and_return("")
    precip.stub(:chance_to_continue).and_return(0)
    precip.stub(:chance_of_rainbow).and_return(0)
    precip_occur = PrecipitationOccurance.new({(0..20) => precip})

    roller = make_roller(10)
    roller.should_receive(:roll).exactly(1) 
    
    precip_occur.type(roller, (20..40))
  end

  it "rerolls if temp is too low" do
    precip = mock(:PrecipitationInfo)
    precip.stub(:min_temp).and_return(20)
    precip.stub(:max_temp).and_return(20)
    precip.stub(:not_allowed_in).and_return([])
    precip.stub(:name).and_return("")
    precip.stub(:chance_to_continue).and_return(0)
    precip.stub(:chance_of_rainbow).and_return(0)
    precip_occur = PrecipitationOccurance.new({(0..20) => precip})

    roller = make_roller(10)
    roller.should_receive(:roll).exactly(2) 
    
    precip_occur.type(roller, (0..10))
  end

  it "rerolls if temp is too high" do
    precip = mock(:PrecipitationInfo)
    precip.stub(:min_temp).and_return(20)
    precip.stub(:max_temp).and_return(20)
    precip.stub(:not_allowed_in).and_return([])
    precip.stub(:name).and_return("")
    precip.stub(:chance_to_continue).and_return(0)
    precip.stub(:chance_of_rainbow).and_return(0)
    precip_occur = PrecipitationOccurance.new({(0..20) => precip})

    roller = make_roller(10)
    roller.should_receive(:roll).exactly(2)

    precip_occur.type(roller, (50..60))
     
  end

  it "checks temp ranges for continuing weather" do
    precipcold = mock(:PrecipitationInfo)
    precipcold.stub(:min_temp).and_return(20)
    precipcold.stub(:max_temp).and_return(20)
    precipcold.stub(:not_allowed_in).and_return([])
    precipcold.stub(:name).and_return("cold")
    precipcold.stub(:chance_to_continue).and_return(0)
    precipcold.stub(:chance_of_rainbow).and_return(0)

    precipwarm = mock(:PrecipitationInfo)
    precipwarm.stub(:min_temp).and_return(30)
    precipwarm.stub(:max_temp).and_return(30)
    precipwarm.stub(:not_allowed_in).and_return([])
    precipwarm.stub(:name).and_return("warm")
    precipwarm.stub(:chance_to_continue).and_return(20)
    precipwarm.stub(:chance_of_rainbow).and_return(0)

    precip_occur = PrecipitationOccurance.new({(0..20) => precipcold, (30..50) => precipwarm})
     
    roller = make_roller(40, 10, 10)
    roller.should_receive(:roll).exactly(3)

    precipitations = precip_occur.type(roller, (30..30))
    precipitations.collect { |p|  p.name }.should == ["warm", "No Precipitation"]
  end


  private
  def make_roller(*rolls)
    roller = mock(:DieRoller)
    roller.stub(:roll).and_return(*rolls)
    roller
  end

  def create_test_precipitation (name)
    precip = mock(:Precipitation)
    precip.stub(:not_allowed_in).and_return([])
    precip.stub(:name).and_return(name)
    precip.stub(:chance_of_rainbow).and_return(0)
    precip.stub(:chance_to_continue).and_return(10)
    precip
  end
end 
