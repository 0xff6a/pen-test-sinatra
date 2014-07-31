describe 'Link: initialization' do
	
	it 'should have no links initially' do
		expect(Link.count).to eq(0)
	end

end

describe Link do

	before(:each) do
		user = create_user('test@test.com', 'test')
		Link.create(:title => "Makers Academy",
								:url => "http://wwww.makersacademy.com/",
								:user_id => user.id,
								:timestamp => Time.now)
	end

	it 'links can be added to the DB' do
		expect(Link.count).to eq(1)
		expect(link.url).to eq("http://wwww.makersacademy.com/")
		expect(link.title).to eq("Makers Academy")
	end

	it 'links can be removed from the DB' do
		link.destroy
		expect(Link.count).to eq(0)
	end

	it 'should have no tags initially' do
		expect(link.tags).to eq []
	end

	it 'can have tags added' do
		link.update(:tags => [Tag.first_or_create(:text => 'education', :user_id => user.id)])
		expect(link.tags.map(&:text)).to eq ['education']
	end

	it 'will not be saved without a valid url' do
		expect { Link.create(:title => "Google",
												:url => "blahblah",
												:user_id => user.id) }.to change { Link.count }.by(0)
		expect { Link.create(:title => "Google",
												:url => "google.com",
												:user_id => user.id) }.to change { Link.count }.by(0)
	end

	it 'should have a timestamp for when it was created' do
		expect(Time.parse(link.timestamp)).to be_within(60).of(Time.now)
	end

	it 'should allow the user to add a description' do

	end

	def link
		Link.first
	end

end