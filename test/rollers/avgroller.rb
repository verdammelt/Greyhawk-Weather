require 'dieroller'

class AvgRoller < DieRoller
  def roll(nsides, modifier=0)
    return nsides/2 + modifier
  end
end
