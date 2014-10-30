require 'helpers/setup'

describe User do

	include SetupHelpers
	
	it 'can be created' do
		expect { create_user('test@test.com', 'test') }.to change { User.count }.by(1)
	end

	it 'will only be created if a valid email is given' do
		expect { create_user('blah', 'test') }.to change { User.count }.by(0)
	end

	it 'will have favourite links' do
		user = create_user('test@test.com', 'test') 
		link = create_link('http://www.google.com','Google','search', user)
		expect(user.favourites.count).to eq(0)
		Favourite.create(:user => user, :link => link)
		expect(user.favourites.count).to eq(1)
		expect(user.favourites.last.link).to eq(link)
	end

end