class Payloads

  attr_reader   :param_keys
  attr_accessor :param_values

  def initialize(param_keys, param_values = [[]])
    @param_keys = param_keys
    @param_values = param_values
  end

end