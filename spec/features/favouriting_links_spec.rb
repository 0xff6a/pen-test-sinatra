require 'helpers/setup'

feature 'Users create favourite links when signed in' do

	include SetupHelpers	

	before(:each) do
		user = create_user('test@test.com', 'test')
		sign_in('test@test.com', 'test')
		add_link('http://www.test.com', 'Test', ['test'], 'testing')
	end
	
	scenario 'favouriting a link while browsing a list of links' do
		visit('/')
		click_button 'favourite-link'
		expect(page).to have_content('Added to favourites')
		expect(user.links.count).to eq(1)
	end

end