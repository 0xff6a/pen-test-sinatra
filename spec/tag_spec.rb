require 'helpers/setup'

describe Tag do

	include SetupHelpers

	before(:each) do
		user = create_user('test@test.com', 'test')
	end

	it 'there are no tags initially' do
		expect(Tag.count).to eq(0)
	end

	it 'can be created' do
		Tag.create(:text => 'education', :user_id => user.id)
		expect(Tag.count).to eq(1)
	end

	it 'must have text to be created' do
		Tag.create(:text => nil, :user_id => user.id)
		expect(Tag.count).to eq(0)
	end
	
end