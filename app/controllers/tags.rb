get '/tags/:text' do |text|
	tag = Tag.first(:text => text)
	@links = tag ? tag.links : []
	@tags = Tag.all
	erb :index
end