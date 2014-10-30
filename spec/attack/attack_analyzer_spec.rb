describe AttackAnalyzer do

  context 'analyzing responses' do

    let(:response)  { double Net::HTTPResponse, body: 'welcome', code: '200' }
    let(:attack)    { double BruteForceAttack, responses: [response]         }

    it 'can check if a response contains a given text fragment' do
      expect(AttackAnalyzer.check_for_response('welcome', attack)).to eq [true]
    end

    it 'can check if a response does not contain a given text fragment' do
      expect(AttackAnalyzer.check_for_response('xyz', attack)).to eq [false]
    end

    it 'can check if a response contains a given text fragment' do
      expect(AttackAnalyzer.check_for_status_code('200', attack)).to eq [true]
    end

    it 'can check if a response does not contain a given text fragment' do
      expect(AttackAnalyzer.check_for_status_code('404', attack)).to eq [false]
    end

  end

end