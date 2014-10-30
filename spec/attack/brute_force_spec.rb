describe BruteForceAttack do
  
  let(:uri)     { 'http://localhost:9292/sessions/'                                }
  let(:attack)  { BruteForceAttack.new(uri)                                        }
  let(:payload) { double Payloads, param_key: 'password', param_values: ['12345678'] }

  context 'initialization' do

    it 'should have a target uri object' do
      expect(attack.target_uri.to_s).to eq uri
    end

    it 'should have a target HTTP request' do
      expect(attack.target_req).to be_an_instance_of(Net::HTTP::Post)
      expect(attack.target_req.uri.to_s).to eq uri
    end

    it 'should have no payloads initially' do
      expect(attack.payloads).to eq []
    end

    it 'should have no responses intially' do
      expect(attack.responses).to eq []
    end

  end

  context 'payloads' do

    it 'payloads can be added' do
      attack.payloads << payload
      expect(attack.payloads).to eq [payload]
    end
  
  end

  context 'launching an attack' do

    let(:req)     { double Net::HTTP::Post      }
    before(:each) { attack.payloads << payload  }

    it 'can generate a set of http requests from a payload' do
      expect(attack).to receive(:create_req_from_payload)
          .with(attack.payloads.first, '12345678')
          .and_return(req)
      expect(attack).to receive(:send_http_request).with(req)
      attack.launch!
    end

    it 'returns the responses for each request' do

    end

  end

end