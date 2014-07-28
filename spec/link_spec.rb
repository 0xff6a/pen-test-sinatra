describe Link do
	
	context 'Demonstration of how datamapper works' do

		it 'should be created then retrieved from the database' do
			expect(Link.count).to eq(0)
			Link.create(:title => "Makers Academy",
									:url => "http://wwww,makersacademy.com/")
			expect(Link.count).to eq(1)
			link = Link.first
			expect(link.url).to eq("http://wwww,makersacademy.com/")
			expect(link.title).to eq("Makers Academy")
			link.destroy
			expect(Link.count).to eq(0)
		end

	end

end