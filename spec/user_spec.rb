describe User do
	
	it 'can be created' do
		expect { create_user('test@test.com', 'test') }.to change { User.count }.by(1)
	end

	it 'will only be created if a valid email is given' do
		expect { create_user('blah', 'test') }.to change { User.count }.by(0)
	end

end