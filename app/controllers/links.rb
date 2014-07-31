get '/links/new' do
	erb :'links/new'
end

post '/links' do
	tags = create_tags(params['tags'])
	link = create_link(params['url'], params['title'], tags )
	redirect to('/') if link.save
	flash.now[:errors] = link.errors.full_messages
	erb :'links/new'
end


