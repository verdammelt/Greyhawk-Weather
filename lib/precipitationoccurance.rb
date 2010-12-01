require 'util/rangehash'

require 'precipitationinfo'
require 'precipitation'

class PrecipitationOccurance < RangeHash
  def self.load(file)
    data = YAML.load_file(file)
    data.each_pair { |k, v| data[k] = PrecipitationInfo.create_from_data(v)}
    PrecipitationOccurance.new(data)
  end

  def initialize(args = nil)
    super args, NullPrecipitationInfo.new()
  end
  
  def type(dieroller, temp_range = nil)
    get_all_precip initial_precip(dieroller, temp_range), dieroller, temp_range
  end
  
  private
  def invalid_precip?(precip_info, temp_range)
    temp_range and 
      ((precip_info.min_temp and !(precip_info.min_temp <= temp_range.last)) or
       (precip_info.max_temp and !(precip_info.max_temp >= temp_range.first)))
  end

  def initial_precip (dieroller, temp_range)
    precip_info = self[dieroller.roll(100)]

    if invalid_precip?(precip_info, temp_range)
        precip_info = self[dieroller.roll(100)]
        
      if invalid_precip?(precip_info, temp_range)
          precip_info = NullPrecipitationInfo.new()
      end
    end
    precip_info
  end

  def get_all_precip (precip_info, dieroller, temp_range)
    all_precip = Array.new().push(Precipitation.new(precip_info, dieroller))

    while precip_continues?(dieroller, precip_info)
      next_precip_info = next_precip_info(dieroller, precip_info)
      precip_info = next_precip_info unless invalid_precip?(next_precip_info, temp_range)
      all_precip.push(Precipitation.new(precip_info, dieroller))
    end

    all_precip
  end

  def precip_continues?(dieroller, precip_info)
    precip_info.chance_to_continue > 0 && 
      dieroller.roll(100) <= precip_info.chance_to_continue
  end

  def next_precip_info(dieroller, precip_info)
    continue_roll = dieroller.roll(10)
    return line_above(precip_info) if continue_roll == 1
    return line_below(precip_info) if continue_roll == 10
    precip_info
  end

  def line_above(precip_info)
    prev_key = sorted_keys[[0,index_of_precip(precip_info)-1].max]
    @key_value_hash[prev_key]
  end
  
  def line_below(precip_info)
    next_key = sorted_keys[[sorted_keys.length,index_of_precip(precip_info)+1].min]
    @key_value_hash[next_key]
  end
  
  def index_of_precip(precip_info)
    key = @key_value_hash.index(precip_info)
    index_of_key = sorted_keys.index(key)
  end
  
end
