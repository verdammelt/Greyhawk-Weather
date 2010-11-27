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
  
  def sorted_keys
    @key_value_hash.keys.sort do |a, b|
      aval = a
      if a.instance_of?(Range)
        aval = a.first
      end
      
      bval = b
      if b.instance_of?(Range)
        bval = b.first
      end
      
      aval <=> bval
    end
  end
end

