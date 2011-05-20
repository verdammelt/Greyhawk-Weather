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
    base = base + record_adjustment(record, :high, @high_adj)
    base = base - record_adjustment(record, :low, @low_adj)
    base
  end

  def count_records(record, type)
	  record.find_all{|r| r == type}.length
  end

  def record_adjustment(record, type, adjustment_values)
    (count_records(record, type) * (adjustment_values[0] + adjustment_values[1]))
  end
  
  def make_record_array(record)
    ((record.class == Array) ? record : [record])
  end
end
