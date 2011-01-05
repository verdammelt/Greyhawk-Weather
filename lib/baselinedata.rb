require 'YAML' unless defined? :YAML

require 'temperaturerange'
require 'skyconditions'
require 'month'

class BaselineData
  def self.load (file)
    BaselineData.new(YAML.load_file(file))
  end
  
  def initialize(data)
    @all_data = data
  end

  def num_months
    @all_data.length
  end

  def month(monthnum)
    month_data = @all_data[monthnum -1]
    Month.new(month_data[:temp_range], make_skyconditions(month_data[:sky_conditions]), month_data[:precipitation_chance])
  end
  
  def make_skyconditions(condition_hash)
    SkyConditions.new condition_hash[:clear], condition_hash[:partly], condition_hash[:cloudy]
  end
end
