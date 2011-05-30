require 'spec_helper'
require 'skyconditions'

describe 'SkyConditions' do
  let(:conditions) { SkyConditions.new((01..23), (24..50), (51..100)) }

  it 'picks from ranges' do
    conditions.condition(rigged_roller_mock(1)).should eq(:clear)
    conditions.condition(rigged_roller_mock(23)).should eq(:clear)
    conditions.condition(rigged_roller_mock(24)).should eq(:partly_cloudy)
    conditions.condition(rigged_roller_mock(50)).should eq(:partly_cloudy)
    conditions.condition(rigged_roller_mock(51)).should eq(:cloudy)
    conditions.condition(rigged_roller_mock(99)).should eq(:cloudy)
    conditions.condition(rigged_roller_mock(100)).should eq(:cloudy)
  end

  it 'should treat 0 as 100' do
    conditions.condition(rigged_roller_mock(0)).should eq(:cloudy)
  end
end
