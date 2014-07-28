feature 'User adds a new link' do
	
	let(:example_url) 	{ 'http://www.makersacademy.com' 	}	
	let(:example_title)	{ 'Makers Academy'								}

	scenario 'When browsing the homepage' do
		expect(Link.count).to eq(0)
		visit '/'
		add_link(example_url, example_title)
		expect(Link.count).to eq(1)
		link = Link.first
		expect(link.url).to eq(example_url)
		expect(link.title).to eq(example_title)
	end

	scenario 'with a few tags' do
		visit '/'
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