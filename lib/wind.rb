
class Wind
  def initialize(dieroller)
    @speed = dieroller.roll(20, -1)
    @direction = [:N, :NE, :E, :SE, :S, :SW, :W, :NW][dieroller.roll(8, -1)]
  end
  
  def to_s
    @speed.to_s + @direction.to_s
  end
end
