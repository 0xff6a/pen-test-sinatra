require_relative 'brute_force.rb'

class AttackAnalyzer

  class << self

    def check_for_response(text, attack)
      attack.responses.map{ |response| !response.body.match(text).nil? }
    end

    def check_for_status_code(code, attack)
      attack.responses.map{ |response| response.code == code }
    end

  end

end