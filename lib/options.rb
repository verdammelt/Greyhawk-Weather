require 'util/dieroller'

class WeatherGeneratorOptions
  attr_reader :month
  attr_reader :num_days
  attr_reader :dieroller
  attr_reader :terrain

  def initialize (args = {})
    @month = args.fetch(:month, 1)
    @num_days = args.fetch(:num_days, 28)
    @dieroller = args.fetch(:dieroller, DieRoller.new)
    @terrain = args.fetch(:terrain, :plains)
  end
end	
