describe Payloads do
  
  let(:payloads) { Payloads.new(['password'], [['12345678', 'open']] ) }

  context 'initialisation' do
    
    it 'should have a param_key' do
      expect(payloads.param_keys).to eq ['password']
    end

    it 'can have a set of param_values' do
      expect(payloads.param_values).to eq [['12345678', 'open']]
    end

    it 'can be initialized with no param values' do
      empty_payloads = Payloads.new(['password'])
      expect(empty_payloads.param_values).to eq [[]]
    end

  end

  context 'param_values' do

    it 'param values can be added' do

    end

  end

end