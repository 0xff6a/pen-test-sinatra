feature 'User browses the list of links and tags' do

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
								user)		
	}

	scenario 'when opening the home page' do
		visit '/'
		expect(page).to have_content('Google')
		expect(page).to have_content('Code.org')
		expect(page).to have_content('education')
		expect(page).to have_content('search')
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

	def create_link(url, title, tag, user)
		Link.create(:url => url, :title => title, 
								:tags => [Tag.first_or_create(:text => tag, :user_id => user.id)], 
								:user_id => user.id,
								:timestamp => Time.now )
	end

end

