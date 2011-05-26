require 'spec_helper'
require 'skyconditions'

describe 'SkyConditions' do
  let(:conditions) { SkyConditions.new((01..23), (24..50), (51..100)) }

  it 'picks from ranges' do
    conditions.condition(mock_roller(1)).should eq(:clear)
    conditions.condition(mock_roller(23)).should eq(:clear)
    conditions.condition(mock_roller(24)).should eq(:partly_cloudy)
    conditions.condition(mock_roller(50)).should eq(:partly_cloudy)
    conditions.condition(mock_roller(51)).should eq(:cloudy)
    conditions.condition(mock_roller(99)).should eq(:cloudy)
    conditions.condition(mock_roller(100)).should eq(:cloudy)
  end

  it 'should treat 0 as 100' do
    conditions.condition(mock_roller(0)).should eq(:cloudy)
  end

  def mock_roller (n)
    mock_roller = mock(:DieRoller)
    mock_roller.stub(:roll).and_return n
    mock_roller
  end
end
