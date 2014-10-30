class BruteForceAttack

  # include data_loader

  attr_reader   :target_req
  attr_accessor :payloads

  def initialize(target_req)
    @target_req = target_req
    @payloads = []
  end

end