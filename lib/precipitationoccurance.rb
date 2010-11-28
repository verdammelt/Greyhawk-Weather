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
    precip_info = initial_precip(dieroller, temp_range)
    check_for_continuing_precip(precip_info, dieroller, temp_range)
  end
  
  private
  def initial_precip (dieroller, temp_range)
    roll = dieroller.roll(100)
    precip_info = self[roll]
    
    if temp_range 
      if (precip_info.min_temp && !(precip_info.min_temp <= temp_range.last)) ||
          (precip_info.max_temp && !(precip_info.max_temp >= temp_range.first))
      roll = dieroller.roll(100)
      precip_info = self[roll]
        
      if (precip_info.min_temp && !(precip_info.min_temp <= temp_range.last)) ||
          (precip_info.max_temp && !(precip_info.max_temp >= temp_range.first))
        roll = dieroller.roll(100)
        precip_info = NullPrecipitationInfo.new()
      end
      end
    end
    precip_info
  end

  def check_for_continuing_precip (precip_info, dieroller, temp_range)
    all_precip = Array.new().push(Precipitation.new(precip_info, dieroller))

    while precip_info.chance_to_continue > 0 && dieroller.roll(100) <= precip_info.chance_to_continue
      continue_roll = dieroller.roll(10)
      if continue_roll == 1
        new_precip_info = line_above(precip_info)
      elsif continue_roll == 10
        new_precip_info = line_below(precip_info)
      end
      
      if new_precip_info
        if temp_range
          if (new_precip_info.min_temp && !(new_precip_info.min_temp <= temp_range.last)) ||
              (new_precip_info.max_temp && !(new_precip_info.max_temp >= temp_range.first))
            precip_info = precip_info
          end
        else
          precip_info = new_precip_info
        end
      end

      all_precip.push(Precipitation.new(precip_info, dieroller))
    end
    all_precip
  end

  def line_above(precip_info)
    key = @key_value_hash.index(precip_info)
    index_of_key = sorted_keys().index(key)
    prev_key = sorted_keys[[0,index_of_key-1].max]
    @key_value_hash[prev_key]
  end
  
  def line_below(precip_info)
    precip_info
    key = @key_value_hash.index(precip_info)
    index_of_key = sorted_keys().index(key)
    prev_key = sorted_keys[[sorted_keys.length,index_of_key+1].min]
    @key_value_hash[prev_key]
  end
  
end
