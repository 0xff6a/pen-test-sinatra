require 'helpers/setup'

describe Favourite do 

	include SetupHelpers
	
	it 'should be able to count how many times a link has been favourited' do
		user1 = create_user('test@test.com', 'test') 
		user2 = create_user('test2@test.com', 'test2') 
		link = create_link('http://www.google.com','Google','search', user)
		Favourite.create(:user => user1, :link => link)
		Favourite.create(:user => user2, :link => link)
		expect(Favourite.count(:link => link)).to eq(2)
	end
	
end