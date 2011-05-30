require 'spec_helper'
require 'temperaturerange'

describe "TemperatureRange" do
  let(:roller) do
     avg_roller_mock()
  end

  subject {TemperatureRange.new(10, [8, 2], [8, 2])}

  it "uses die roller for range construction" do
    subject.range(roller).should == (4..16)
  end

  it "handles record highs and lows (including mixtures" do
    HIGHS_AND_LOWS = {
      :high => (14..26),
      [:high, :high] => (24..36),
      :low => (-6..6),
      [:low, :low] => (-16..-4),
      [:high, :low] => (4..16),
      [:high, :low, :high] => (14..26) }

    HIGHS_AND_LOWS.each { |record, temp_range|
      subject.range(roller, record) == temp_range }
  end
end
