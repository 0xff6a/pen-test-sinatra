feature 'User adds a new link when signed in' do
	
	let(:example_url) 	{ 'http://www.makersacademy.com' 	}	
	let(:example_title)	{ 'Makers Academy'								}

	before(:each) do
		create_user('test@test.com', 'test')
		sign_in('test@test.com', 'test')
	end

	scenario 'When browsing the homepage' do
		expect(Link.count).to eq(0)
		visit '/'
		click_link 'add-link'
		add_link(example_url, example_title)
		expect(Link.count).to eq(1)
		link = Link.first
		expect(link.url).to eq(example_url)
		expect(link.title).to eq(example_title)
		expect(Time.parse(link.timestamp)).to be_within(60).of(Time.now)
	end

	scenario 'with a few tags' do
		visit '/links/new'
		add_link(example_url, example_title, ['education', 'ruby'])
		link = Link.first
		expect(link.tags.map(&:text)).to include('education')
		expect(link.tags.map(&:text)).to include('ruby')
	end

	def add_link(url, title, tags = [])
		within('#new-link') do
			fill_in 'url', :with => url
			fill_in 'title', :with => title
			fill_in 'tags', :with => tags.join(' ')
			click_button 'Add link'
		end
	end

end