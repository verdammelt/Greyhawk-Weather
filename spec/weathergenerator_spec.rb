require 'weathergenerator'

describe 'WeatherGenerator' do
  let(:roller) do
    roller = mock(:DieRoller)
    roller.stub(:roll) { |nsides, modifier| nsides/2 + (modifier || 0) }
    roller
  end
  let(:baseline) do
    baseline = mock(:BaselineData)
    baseline.stub(:month) do |m|
      month = mock(:month)
      month.stub(:temp_range) { m..m+1 }
      month
    end
    baseline
  end

  before(:each) do
    SingleDayWeather.stub(:new) do |m, roller, precip, hilo, terrain|
      day = mock(:SingleDayWeather)
      day.stub(:temperature_range) { m.temp_range }
      day.stub(:record){ hilo }
      day.stub(:terrain) { terrain }
      day
    end
  end

  it 'creates num_days of weather' do
    generator = WeatherGenerator.new baseline, nil, 1, 13, roller
    generator.days.length.should == 13
  end

  it 'generates weather accorss month boundaries' do
    baseline.stub(:num_months) { 2 }

    generator = WeatherGenerator.new baseline, nil, 1, 31, roller
    generator.days.select {|d| d.temperature_range.begin == 1 }.length.should == 28
    generator.days.select {|d| d.temperature_range.begin == 2 }.length.should == 3
  end

  it 'generates days across year boundaries' do
    baseline.stub(:num_months) { 2 }
    generator = WeatherGenerator.new baseline, nil, 2, 29, roller
    generator.days.last.temperature_range.begin.should == 1
  end

  it 'checks for record high and low' do
    roller.stub(:roll) { 1 }
    generator = WeatherGenerator.new baseline, nil, 1, 1, roller
    generator.days.first.record.should == [:low, :low, :low]
  end

  it 'uses terrain for precipitation check' do
    generator = WeatherGenerator.new baseline, nil, 1, 1, roller, :desert
    generator.days.first.terrain.should == :desert
  end
end
