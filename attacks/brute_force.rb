require 'net/http'

class BruteForceAttack

  attr_reader   :target_uri, :target_req, :payloads
  attr_accessor :fixed_req_params, :responses

  def initialize(target_uri)
    @target_uri       = URI.parse(target_uri)
    @target_req       = set_target_req
    @fixed_req_params = {}
    @payloads         = []
    @responses        = []
  end

  def set_fixed_req_params(params)
    @fixed_req_params = params
  end

  def launch!
    @responses = (0...payload_size).map{ |index| launch_attack(index) }
  end

  def add_payloads(payload_array)
    payload_error_handler(payload_array)
    @payloads += payload_array
    self
  end

  private

  def launch_attack(index)
    fire_req(create_params(index))
  end

  def create_params(index)
    params = fixed_req_params
    @payloads.each { |payload| params[payload.param_key] = payload.param_values[index] }
    params
  end

  def fire_req(params)
    send_http_request(create_post_req(params))
  end

  def send_http_request(req)
    Net::HTTP.start(target_uri.hostname, target_uri.port){ |http| http.request(req) }
  end

  def create_post_req(params)
    req = target_req.clone
    req.set_form_data(params)
    req
  end

  def payload_error_handler(payload_array)
    raise 'cannot have different size payloads' unless all_same_size?(payload_array)
  end

  def all_same_size?(payload_array)
    all_payloads = payloads + payload_array
    all_payloads.all?{ |payload| payload.size == all_payloads.first.size}
  end

  def payload_size
    payloads.first.size
  end

  def set_target_req
    Net::HTTP::Post.new(target_uri)  
  end

end