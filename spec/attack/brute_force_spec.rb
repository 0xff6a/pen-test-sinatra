describe BruteForceAttack do
  
  let(:uri)       { 'http://fast-sierra-4695.herokuapp.com/sessions/'                            }
  let(:attack)    { BruteForceAttack.new(uri)                                                     }
  let(:payload)   { double PayloadSet, param_key: 'password', param_values: ['12345678'], size: 1 }
  let(:payload_2) { double PayloadSet, param_key: 'email', param_values: ['me@me.com'], size: 1   }

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
      attack.add_payloads([payload])
      expect(attack.payloads).to eq [payload]
    end

    it 'cannot accept payloads of different size' do
      big = double PayloadSet, size: 10
      attack.add_payloads([payload])
      expect{ attack.add_payloads([big]) }.to raise_error(RuntimeError, 'cannot have different size payloads')
    end
  
  end

  context 'launching an attack' do

    let(:req)     { double Net::HTTP::Post          }
    before(:each) { attack.add_payloads([payload])  }

    it 'can generate an http request from a single payload' do
      expect(attack).to receive(:create_post_req)
          .with({'password' => '12345678'})
          .and_return(req)
      expect(attack).to receive(:send_http_request).with(req)
      attack.launch!
    end

    it 'can generate an http request from mulitple payloads' do
      attack.add_payloads([payload_2])
      expect(attack).to receive(:create_post_req)
          .with({'password' => '12345678', 'email' => 'me@me.com'})
          .and_return(req)
      expect(attack).to receive(:send_http_request).with(req)
      attack.launch!
    end


    it 'saves the responses for each request' do
      allow(attack).to receive(:send_http_request).and_return('200')
      attack.launch!
      expect(attack.responses.first).to eq '200'
    end

  end

  context 'fixed request params' do

    let(:params)  { { 'rack.session' => '12345678', 'email' => 'me@me.com'} }
    
    before(:each) do
       attack.add_payloads([payload])  
       attack.set_fixed_req_params(params) 
       allow(attack).to receive(:send_http_request).and_return(nil)                       
    end

    it 'can accept fixed params to be added to each http request' do
      expect(attack.fixed_req_params).to eq params
    end

    it 'fixed params will be added to each http request' do
      all_params = params.merge({'password' => '12345678'})
      expect(attack).to receive(:create_post_req).with(all_params)
      attack.launch!
    end

  end

end