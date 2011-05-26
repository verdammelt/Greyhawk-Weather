require 'spec_helper'
require 'skyconditions'

describe 'SkyConditions' do
  let(:conditions) { SkyConditions.new((01..23), (24..50), (51..100)) }

  it 'picks from ranges' do
    conditions.condition(mock_roller(1)).should == :clear
    conditions.condition(mock_roller(23)).should == :clear
    conditions.condition(mock_roller(24)).should == :partly_cloudy
    conditions.condition(mock_roller(50)).should == :partly_cloudy
    conditions.condition(mock_roller(51)).should == :cloudy
    conditions.condition(mock_roller(99)).should == :cloudy
    conditions.condition(mock_roller(100)).should == :cloudy
  end

  it 'should treat 0 as 100' do
    conditions.condition(mock_roller(0)).should == :cloudy
  end

  def mock_roller (n)
    mock_roller = mock(:DieRoller)
    mock_roller.stub(:roll).and_return n
    mock_roller
  end
end
