require 'net/http'

class BruteForceAttack

  attr_reader   :target_uri, :target_req, :payloads
  attr_accessor :responses

  def initialize(target_uri)
    @target_uri = URI.parse(target_uri)
    @target_req = set_target_req
    @payloads   = []
    @responses  = []
  end

  def launch!
    @payloads.each{ |payload| @responses << launch_payload(payload) }
  end

  def add_payloads(payload_array)
    payload_error_handler
    @payloads += payload_array
    self
  end

  private

  def launch_payload(payload)
   payload.param_values.map do |value| 
      req = create_req_from_payload(payload, value)
      send_http_request(req)
    end
  end

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

  def payload_error_handler
    raise 'cannot have more than 2 payloads' if max_payloads?
  end
  
  def max_payloads?
    payloads.count >= 2
  end

end