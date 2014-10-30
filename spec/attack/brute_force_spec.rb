describe BruteForceAttack do
  
  let(:uri)     { URI.parse('http://localhost:9292/sessions/')      }
  let(:req)     { Net::HTTP::Post.new(uri)                          }
  let(:attack)  { BruteForceAttack.new(req)                         }

  context 'initialization' do

    it 'should have a template HTTP request' do
      expect(attack.target_req).to eq req
    end

    it 'should have no payloads initially' do
      expect(attack.payloads).to eq []
    end

  end

  context 'payloads' do

    let(:payload) { double Payload, post_key: 'password', post_value: '12345678' }

    it 'payloads can be added' do
      attack.payloads << payload
      expect(attack.payloads).to eq payload
    end
  
  end

end