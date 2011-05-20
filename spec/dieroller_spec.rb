require 'util/dieroller'

describe DieRoller do
  it "should use Kernel::rand" do
    subject.stub(:rand).and_return 0
    subject.should_receive(:rand).with(6)
    subject.roll(6)
  end

  it "should return random number +1" do
    subject.stub(:rand).and_return 0
    subject.should_receive :rand
    subject.roll(6).should == 1
  end

  it "should apply modifier if given" do
    subject.stub(:rand).and_return 1
    subject.roll(6, 2).should equal 4
    subject.roll(6, -3).should == -1
  end
end
