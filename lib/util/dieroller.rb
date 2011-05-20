class DieRoller
  def roll(num_sides, modifier=0)
    rand(num_sides) + 1 + modifier
  end
end

class NullDieRoller
  def roll(num_sides, modifier=0)
    -1
  end
end
