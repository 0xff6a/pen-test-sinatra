get '/links/new' do
	erb :'links/new'
end

post '/links' do
	tags = create_tags(params['tags'])
	create_link(params['url'], params['title'], tags )
	redirect to('/')
end


