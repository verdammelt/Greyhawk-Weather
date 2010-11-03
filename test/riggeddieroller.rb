require 'dieroller'

class RiggedDieRoller < DieRoller
  def initialize(roll)
    @roll = roll
  end

  def roll(nsides, modifier=0)
    @roll + modifier
  end
end
