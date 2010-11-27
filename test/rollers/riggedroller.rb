require 'util/dieroller'

class RiggedRoller < DieRoller
  def initialize(*rolls)
    @last_roll = rolls.pop
    @rolls = rolls.reverse
  end
  def roll(nSides, modifier=0)
    (@rolls.pop || @last_roll) + modifier
  end
end
