require 'net/http'

require_relative 'brute_force'
require_relative 'payload_set'

def setup_attack
  target = ARGV.first
  attack = BruteForceAttack.new(target)

  usernames = PayloadSet.new('email')
  passwords = PayloadSet.new('password')

  usernames.add_values_from_file('users.txt')
  passwords.add_values_from_file('passwords.txt')

  attack.add_payloads([usernames, passwords])
end

def launch_attack
  setup_attack
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


