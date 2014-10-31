describe PayloadSet do
  
  let(:payloads)        { PayloadSet.new('password', ['12345678', 'open'] ) }
  let(:empty_payloads)  { PayloadSet.new('password')                        }
  
  context 'initialisation' do
    
    it 'should have a param_key' do
      expect(payloads.param_key).to eq 'password'
    end

    it 'can have a set of param_values' do
      expect(payloads.param_values).to eq ['12345678', 'open']
    end

    it 'can be initialized with no param values' do
      expect(empty_payloads.param_values).to eq []
    end

  end

  context 'param_values' do

    it 'param values can be added' do
      empty_payloads.add_values(['12345678'])
      expect(empty_payloads.param_values).to eq ['12345678']
    end

    it 'can read param values from a file' do
      allow(File).to receive(:read)
          .with('dummy.txt')
          .and_return("a\nb")
      empty_payloads.add_values_from_file('dummy.txt')
      expect(empty_payloads.param_values).to eq ['a', 'b']
    end

    it 'can create param values given a function and number of elements' do
      allow(PayloadSet).to receive(:generate_cookie).and_return('xyz').exactly(2).times
      empty_payloads.add_values_from_function(:generate_cookie, 2)
      expect(empty_payloads.param_values).to eq ['xyz', 'xyz']
    end

  end

  context '#size' do

    it 'knows the number of param values in the payload' do
      expect(payloads.size).to eq 2
    end

  end

end