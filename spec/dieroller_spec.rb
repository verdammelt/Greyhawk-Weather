require 'spec_helper'

require 'util/dieroller'

describe DieRoller do
  it "should use Kernel::rand" do
    subject.stub(:rand).and_return 0
    subject.should_receive(:rand)
    subject.roll(6)
  end
end
