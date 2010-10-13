class BaselineData
  def initialize
    @base_temps = [32, 34, 42, 52, 63, 71, 77, 75, 68, 57, 46, 33]
    @base_temp_ranges = [{ :high => [10, 0], :low => [20, 0]}, 
                         { :high => [6, 4], :low => [10, 4]},
                         { :high => [8, 4], :low => [10, 4]},
                         { :high => [10, 6], :low => [8, 4]},
                         { :high => [10, 6], :low => [10, 6]},
                         { :high => [8, 8], :low => [6, 6]},
                         { :high => [6, 4], :low => [6, 6]},
                         { :high => [4, 6], :low => [6, 6]},
                         { :high => [8, 6], :low => [8, 6]},
                         { :high => [10, 5], :low => [10, 5]},
                         { :high => [10, 6], :low => [10, 4]},
                         { :high => [8, 5], :low => [20, 0]}]
  end

  def month(monthnum)
    Month.new @base_temps[monthnum - 1], @base_temp_ranges[monthnum -1]
  end
end
