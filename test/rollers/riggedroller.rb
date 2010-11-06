require 'dieroller'

class RiggedRoller < DieRoller
  def initialize(roll)
    @roll = roll
  end
  def roll(nSides, modifier=0)
    @roll + modifier
  end
end
