class Payloads

  attr_reader   :param_key
  attr_accessor :param_values

  def initialize(param_key, param_values = [])
    @param_key = param_key
    @param_values = param_values
  end

  def add_values(param_values)
    @param_values += param_values
  end

end