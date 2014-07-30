describe 'Link: initialization' do
	
	it 'should have no links initially' do
		expect(Link.count).to eq(0)
	end

end

describe Link do

	before(:each) do
		Link.create(:title => "Makers Academy",
								:url => "http://wwww.makersacademy.com/",
								:user_id => 1)
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
		link.update(:tags => [Tag.first_or_create(:text => 'education', :user_id => 1)])
		expect(link.tags.map(&:text)).to eq ['education']
	end

	it 'will not be saved without a valid url' do
		expect { Link.create(:title => "Google",
												:url => "blahblah",
												:user_id => 1) }.to change { Link.count }.by(0)
		expect { Link.create(:title => "Google",
												:url => "google.com",
												:user_id => 1) }.to change { Link.count }.by(0)
	end

	def link
		Link.first
	end

end