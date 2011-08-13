require 'YAML' unless defined? YAML

require 'rangehash'

require 'precipitationinfo'
require 'precipitation'

class PrecipitationOccurance < RangeHash
  def self.load(file)
    data = YAML.load_file(file)
    data.each_pair { |k, v| data[k] = PrecipitationInfo.create_from_data(v)}
    PrecipitationOccurance.new(data)
  end

  def initialize(args = {})
    super NullPrecipitationInfo.new()
    merge!(args)
  end
  
  def type(dieroller, temp_range = nil, terrain = :plains)
    get_all_precip initial_precip(dieroller, temp_range, terrain), dieroller, temp_range, terrain
  end
  
  private
  def invalid_precip?(precip_info, temp_range, terrain)
    (temp_range and 
      ((precip_info.min_temp and !(precip_info.min_temp <= temp_range.last)) or
       (precip_info.max_temp and !(precip_info.max_temp >= temp_range.first)))) or
      (terrain and precip_info.not_allowed_in.include?(terrain))
  end

  def initial_precip (dieroller, temp_range, terrain)
    precip_info = self[dieroller.roll(100)]

    if invalid_precip?(precip_info, temp_range, terrain)
        precip_info = self[dieroller.roll(100)]
        
      if invalid_precip?(precip_info, temp_range, terrain)
          precip_info = NullPrecipitationInfo.new()
      end
    end
    precip_info
  end

  def get_all_precip (precip_info, dieroller, temp_range, terrain)
    all_precip = Array.new().push(Precipitation.new(precip_info, dieroller))

    while precip_continues?(dieroller, precip_info)
      next_precip_info = next_precip_info(dieroller, precip_info)
      precip_info = next_precip_info unless invalid_precip?(next_precip_info, temp_range, terrain)
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
    current_index = index_of_precip(precip_info) || 0
    prev_key = sorted_keys[[0,current_index-1].max]
    self[prev_key]
  end
  
  def line_below(precip_info)
    current_index = index_of_precip(precip_info) || sorted_keys.length
    index = [sorted_keys.length,current_index+1].min
    next_key = sorted_keys[index]
    self[next_key]
  end
  
  def index_of_precip(precip_info)
    pair = select {|k, v| v == precip_info }.first
    key = pair.first
    index_of_key = sorted_keys.index(key) 
  end
end
