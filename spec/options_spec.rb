require 'options'

describe 'WeatherGeneratorOptions' do

  describe 'defaults' do
    subject { WeatherGeneratorOptions.new }
    its (:month) { should == 1 }
    its (:num_days) { should == 28 }
    its (:terrain) { should == :plains }
    its (:dieroller) { should be_instance_of (DieRoller) }
  end

  describe 'overriding defaults' do
    class SpecialDieRoller < DieRoller
    end
    subject { WeatherGeneratorOptions.new ({:month => 4,
                                             :num_days => 10,
                                             :terrain => :hills,
                                             :dieroller => SpecialDieRoller.new})}
    its (:month) { should == 4 }
    its (:num_days) { should == 10 }
    its (:terrain) { should == :hills }
    its (:dieroller) { should be_instance_of (SpecialDieRoller) }
  end
end
