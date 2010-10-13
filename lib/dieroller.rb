class DieRoller
  def roll(nSides, modifier=0)
    rand(nSides) + 1 + modifier
  end
end
