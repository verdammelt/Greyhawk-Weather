class TemperatureRange
  def initialize (base, high_adj, low_adj)
    @base = base
    @high_adj = high_adj
    @low_adj = low_adj
  end
  
  def range (roller)
    (@base - roller.roll(@low_adj[0], @low_adj[1])..@base+ roller.roll(@high_adj[0], @high_adj[1]))
  end
end
