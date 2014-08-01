require 'helpers/setup'

feature 'Users favourites' do

	include SetupHelpers	

	before(:each) do
		user = create_user('test@test.com', 'test')
		sign_in('test@test.com', 'test')
		add_link('http://www.test.com', 'Test', ['test'], 'testing')
	end
	
	scenario 'favouriting a link while browsing a list of links' do
		visit('/')
		click_button 'fav'
		expect(page).to have_content('Added to favourites')
		expect(user.links.count).to eq(1)
	end

	scenario 'navigating to a favourites page' do
		visit('/')
		click_button 'fav'
		add_link('http://www.notfav.com', 'Not Fav', ['test'], 'testing')
		visit('/')
		click_on 'profile-button'
		expect(page).to have_content('Test')
		expect(page).not_to have_content('Not Fav')
	end

end