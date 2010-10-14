
class BaselineData
  def initialize
    @all_data = YAML.load_file("./data/baselinedata.yml")
  end
  
  def num_months
    @all_data.length
  end

  def month(monthnum)
    month_data = @all_data[monthnum -1]
    Month.new month_data[:base], month_data[:range]
  end
end
