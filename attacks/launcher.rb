require 'net/http'

require_relative 'brute_force'
require_relative 'payload_set'

def parse(hash_string)
  hash = {}
  hash_string.split(',').each do |pair|
    key,value = pair.split(/:/)
    hash[key] = value
  end
  hash
end

def payload_factory(params)
  name, filepath = params.split(':')
  PayloadSet.new(name).add_values_from_file(filepath)
end

def setup_attack
  target = ARGV.shift
  fixed_params = parse(ARGV.shift)

  attack = BruteForceAttack.new(target)
  attack.set_fixed_req_params(fixed_params) if fixed_params.any?

  payloads = ARGV.map do |params|
    payload_factory(params)
  end
  
  attack.add_payloads(payloads)
end

def launch_attack
  attack = setup_attack
  attack.launch!
  p attack.check_for_status_code('303')
end

def print_usage_msg
  puts '[usage] target fixed_request_params attribute:file attribute:file' 
end

def run
  unless ARGV.first
    print_usage_msg
  else
    launch_attack
  end
end

#=========!!!!=========
#=======Run Call=======
#=========!!!!=========
run


