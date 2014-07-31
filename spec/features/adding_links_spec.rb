require 'helpers/setup'

feature 'User adds a new link when signed in' do

	include SetupHelpers
	
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
		add_link(example_url, example_title, ['education', 'ruby'])
		link = Link.first
		expect(link.tags.map(&:text)).to include('education')
		expect(link.tags.map(&:text)).to include('ruby')
	end

	scenario 'with a description' do
		add_link(example_url, example_title, ['education'], 'Nice link')
		link = Link.first
		expect(link.description).to eq 'Nice link'
	end

end