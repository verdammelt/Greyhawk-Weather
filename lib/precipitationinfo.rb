class PrecipitationInfo
  attr_reader :name
  attr_reader :min_temp
  attr_reader :max_temp
  attr_reader :chance_to_continue
  attr_reader :chance_of_rainbow
  attr_reader :not_allowed_in

  def self.create_from_data(arg_hash)
    PrecipitationInfo.new(arg_hash[:name], 
                          arg_hash[:min_temp], 
                          arg_hash[:max_temp], 
                          arg_hash[:chance_to_continue], 
                          arg_hash[:chance_of_rainbow], 
                          arg_hash[:not_allowed_in])
  end
  
  def initialize(name, min_temp=nil, max_temp=nil, chance_to_continue=0, chance_of_rainbow=0, not_allowed_in=[])
    @name = name
    @min_temp = min_temp
    @max_temp = max_temp
    @chance_to_continue = chance_to_continue || 0
    @chance_of_rainbow = chance_of_rainbow || 0
    @not_allowed_in = not_allowed_in || []
  end
end

class NullPrecipitationInfo < PrecipitationInfo
  def initialize()
    super "No Precipitation"
  end
end
