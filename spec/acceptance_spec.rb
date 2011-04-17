require 'spec_helper'

require 'greyhawkweathergenerator'

describe "Acceptance Tests" do
  context GreyhawkWeatherGenerator do
    let (:roller) do 
      r = mock(:DieRoller)
      r.stub(:roll) { |nsides, modifier| nsides/2 + (modifier || 0) }
      r
    end

    context "generates weather with" do
      let(:weather) { GreyhawkWeatherGenerator.create_weather_generator(4, 1, roller).days[0] }
      subject { weather }
      its(:temperature_range) { should == (44..63) }
      its(:sky_conditions) {  should == :partly_cloudy }

      its(:precipitation) {  should be_a_kind_of(Array) }
      its(:precipitation) {  should be }
      
      describe "precipation" do
        subject { weather.precipitation[0] }
        it { should be_a_kind_of(Precipitation) } 
        its(:name) { should == NullPrecipitationInfo.new.name }
      end
    end
    
    it "should generate multiple days" do
      num_days = 3
      generator = GreyhawkWeatherGenerator.create_weather_generator(4, num_days, roller)
      generator.days.should have(num_days).items
      generator.days.should_not include(nil)
    end
    
    it "generates weather for the given month" do
      generator = GreyhawkWeatherGenerator.create_weather_generator(8, 1, roller)
      weather = generator.days[0]
      weather.temperature_range.should == (66..83)
      weather.sky_conditions.should == :partly_cloudy
    end

    it "generates weather given a terrain" do
      roller = mock(:DieRoller)
      roller.stub(:roll) { |nsides, modifier| 01 }
      generator = GreyhawkWeatherGenerator.create_weather_generator(1, 1, roller, :desert)
      weather = generator.days[0]
      weather.precipitation[0].name.should == NullPrecipitationInfo.new().name
    end
  end
end
