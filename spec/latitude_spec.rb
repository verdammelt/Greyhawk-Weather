require 'singledayweather'
require 'util/dieroller'

describe "Base temperature modified by latitude" do
  let(:test_range) {  10..15 }
  let(:month) {  double :Month, :temp_range => test_range, :sky_conditions => nil, :has_precipitation => false }
  let(:roller) {  double :DieRoller, :roll => 0 }
  let(:precip) {  double :PrecipitationOccurance, :type => nil }
  let(:single_day_weather) {  SingleDayWeather.new(month, roller, precip, nil, :plains) }

  it "should increase base temp by 2 degrees Farenheit for each degree latitude below 40" do
    pending("need to do refactoring first")
    single_day_weather.temperature_range.should == Range.new(test_range.first+10, test_range.last+10)
  end 
end
