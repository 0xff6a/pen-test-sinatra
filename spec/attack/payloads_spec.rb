describe Payloads do
  
  let(:payloads)        { Payloads.new('password', ['12345678', 'open'] ) }
  let(:empty_payloads)  { Payloads.new('password')                        }
  
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

  end

end