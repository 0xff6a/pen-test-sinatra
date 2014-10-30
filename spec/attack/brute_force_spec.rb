describe BruteForceAttack do
  
  let(:uri)     { 'http://localhost:9292/sessions/'   }
  let(:attack)  { BruteForceAttack.new(uri)           }

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

  end

  context 'payloads' do

    let(:payload) { double Payloads, post_key: 'password', post_values: ['12345678'] }

    it 'payloads can be added' do
      attack.payloads << payload
      expect(attack.payloads).to eq [payload]
    end
  
  end

end