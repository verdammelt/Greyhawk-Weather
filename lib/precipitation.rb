class Precipitation
  attr_reader :name
  def initialize(info, dieroller)
    @name = info.name
    @chance_for_rainbow = info.chance_of_rainbow
    @roller = dieroller
  end
  
  def rainbow?
    @chance_for_rainbow > 0 && @roller.roll(100) <= @chance_for_rainbow
  end

  def to_s
    "[#{@name}; rainbow: #{rainbow?}]"
  end
end
