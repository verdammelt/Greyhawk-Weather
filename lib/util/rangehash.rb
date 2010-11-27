class RangeHash
  def initialize (key_value_hash, default_value=nil)
    @key_value_hash = key_value_hash || Hash.new()
    @default_item = [nil, default_value]
  end
  
  def [](key)
    (@key_value_hash.find{ |kv| kv[0] === key } || @default_item)[1]
  end
  
  def to_s
    @key_value_hash.to_s
  end
end

