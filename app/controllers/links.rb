get '/links/new' do
	erb :'links/new'
end

post '/links' do
	tags = create_tags(params['tags'])
	link = create_link(params['url'], params['title'], tags, params[:description] )
	redirect to('/') if link.save
	link_error_handler(link)
end


