require 'dieroller'

class AvgDieRoller < DieRoller
  def roll(nSides, modifier = 0)
    (nSides + 1)/2 + modifier
  end
end

