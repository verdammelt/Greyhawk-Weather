class BaselineData
  def month(monthnum)
    Month.new [32, 34, 42, 52, 63, 71, 77, 75, 68, 57, 46, 33][monthnum - 1]
  end
end
