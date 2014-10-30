require 'net/http'

class BruteForceAttack

  attr_reader   :target_uri, :target_req
  attr_accessor :payloads

  def initialize(target_uri)
    @target_uri = URI.parse(target_uri)
    @target_req = set_target_req
    @payloads = []
  end

  def launch!
    @payloads.each do |payload|
      payload.param_values.map do |value| 
        req = target_req.clone
        req.set_form_data(payload.param_key => value)
        Net::HTTP.start(target_uri.hostname, target_uri.port){ |http| http.request(req) }
      end
    end
  end

  private

  def set_target_req
    Net::HTTP::Post.new(target_uri)  
  end

end