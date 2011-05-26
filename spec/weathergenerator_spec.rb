require 'spec_helper'
require 'weathergenerator'
require 'options'

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
    options = WeatherGeneratorOptions.new({:month => 1, :num_days => 13, :dieroller => roller })
    generator = WeatherGenerator.new baseline, nil, options
    generator.days.length.should == 13
  end

  it 'generates weather across month boundaries' do
    baseline.stub(:num_months) { 2 }

    options = WeatherGeneratorOptions.new({:month => 1, :num_days => 31, :dieroller => roller })
    generator = WeatherGenerator.new baseline, nil, options
    generator.days.select {|d| d.temperature_range.begin == 1 }.should have(28).items
    generator.days.select {|d| d.temperature_range.begin == 2 }.length.should == 3
  end

  it 'generates days across year boundaries' do
    baseline.stub(:num_months) { 2 }
    options = WeatherGeneratorOptions.new({:month => 2, :num_days => 29, :dieroller => roller })
    generator = WeatherGenerator.new baseline, nil, options
    generator.days.last.temperature_range.begin.should == 1
  end

  it 'checks for record high and low' do
    roller.stub(:roll) { 1 }
    options = WeatherGeneratorOptions.new({:month => 1, :num_days => 1, :dieroller => roller })
    generator = WeatherGenerator.new baseline, nil, options
    generator.days.first.record.should == [:low, :low, :low]
  end

  it 'uses terrain for precipitation check' do
    options = WeatherGeneratorOptions.new({:month => 1, :num_days => 1, :dieroller => roller, :terrain => :desert })
    generator = WeatherGenerator.new baseline, nil, options
    generator.days.first.terrain.should == :desert
  end
end
