class TemperatureRange
  def initialize (base, high_adj, low_adj)
    @base = base
    @high_adj = high_adj
    @low_adj = low_adj
  end
  
  def range (roller, record=nil)
    base = calculate_todays_base(record)
    (base - roller.roll(@low_adj[0], @low_adj[1])..base+ roller.roll(@high_adj[0], @high_adj[1]))
  end
  
  private
  def calculate_todays_base(record)
    record = make_record_array record

    base = @base
    base = base + (record.find_all{ |r| r == :high}.length * (@high_adj[0] + @high_adj[1]))
    base = base - (record.find_all{ |r| r == :low}.length * (@low_adj[0] + @low_adj[1]))
    base
  end
  
  def make_record_array(record)
    ((record.class == Array) ? record : [record])
  end
end
