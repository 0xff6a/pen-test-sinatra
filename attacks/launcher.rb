require 'net/http'

require_relative 'brute_force'
require_relative 'payload_set'

def payload_factory(params)
  name, filepath = params.split(':')
  PayloadSet.new(name).add_values_from_file(filepath)
end

def setup_attack
  target = ARGV.shift
  attack = BruteForceAttack.new(target)

  payloads = ARGV.map do |params|
    payload_factory(params)
  end

  attack.add_payloads(payloads)
end

def launch_attack
  puts setup_attack.launch!
  # launch attack
  # analyze response
end

def print_usage_msg
  puts '[usage] target attribute:file attribute:file...' 
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


