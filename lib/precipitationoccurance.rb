require 'util/rangehash'

class PrecipitationOccurance < RangeHash
  def self.load(file)
    data = YAML.load_file(file)
    data.each_pair { |k, v| data[k] = PrecipitationInfo.create_from_data(v)}
    PrecipitationOccurance.new(data)
  end

  def initialize(args)
    super args, :none
  end
  
  def type(dieroller)
    roll = dieroller.roll(100)
    Array.new().push(self[roll])
  end
end
