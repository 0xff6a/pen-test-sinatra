get '/links/new' do
	erb :'links/new'
end

post '/links' do
	url = params['url']
	title = params['title']
	tags = create_tags(params['tags'])
	Link.create(:url => url, :title => title, :tags => tags, :user_id => session[:user_id] )
	redirect to('/')
end

def create_tags(text)
	text.split(' ').map do |tag| 
		Tag.first_or_create(:text => tag, :user_id => session[:user_id]) 
	end
end