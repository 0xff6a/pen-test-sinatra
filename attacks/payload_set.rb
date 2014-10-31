class PayloadSet

  attr_reader   :param_key
  attr_accessor :param_values

  def initialize(param_key, param_values = [])
    @param_key = param_key
    @param_values = param_values
  end

  def size
    param_values.count
  end

  def add_values(param_values)
    @param_values += param_values
  end

  def add_values_from_file(filepath)
    @param_values += File.read(filepath).split("\n")
    self
  end

end