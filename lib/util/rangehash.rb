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
      sort_key(a) <=> sort_key(b)
    end
  end

  private
  
  def sort_key(a)
    # return a if Fixnum === a
    # return a.first if Range === a

    return a.first if Range === a
    a
  end

end

