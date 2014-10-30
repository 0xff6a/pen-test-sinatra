require 'net/http'

class BruteForceAttack

  attr_reader   :target_uri, :target_req
  attr_accessor :payloads, :responses

  def initialize(target_uri)
    @target_uri = URI.parse(target_uri)
    @target_req = set_target_req
    @payloads   = []
    @responses  = []
  end

  def launch!
    @payloads.each do |payload|
      payload.param_values.map do |value| 
        req = create_req_from_payload(payload, value)
        # puts req.to_yaml
        send_http_request(req)
      end
    end
  end

  private

  def set_target_req
    Net::HTTP::Post.new(target_uri)  
  end

  def send_http_request(req)
    Net::HTTP.start(target_uri.hostname, target_uri.port){ |http| http.request(req) }
  end

  def create_req_from_payload(payload, value)
    req = target_req.clone
    req.set_form_data(payload.param_key => value)
    req
  end

end