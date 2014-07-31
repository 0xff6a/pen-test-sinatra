require 'helpers/setup'

feature 'User browses the list of links and tags' do

	include SetupHelpers

	before(:each) {
		user = create_user('test@test.com', 'test')

		create_link('http://www.makersacademy.com',
								'Makers Academy',
								'education',
								user)
		create_link('http://www.google.com',
								'Google',
								'search',
								user)
		create_link('http://www.code.org',
								'Code.org',
								'education',
								user)
		create_link('http://www.bing.com',
								'Bing',
								'search',
								user, 'The second best search')		
	}

	scenario 'when opening the home page' do
		visit '/'
		expect(page).to have_content('Google')
		expect(page).to have_content('Code.org')
		expect(page).to have_content('education')
		expect(page).to have_content('search')
		expect(page).to have_content('The second best search')
	end

	scenario 'filtered by a tag' do
		visit '/'
		within('#tags') do
			click_on 'education'
		end
		expect(page).to have_content('Makers Academy')
		expect(page).to have_content('Code.org')
		expect(page).not_to have_content('Google')
		expect(page).not_to have_content('Bing')
	end

end

