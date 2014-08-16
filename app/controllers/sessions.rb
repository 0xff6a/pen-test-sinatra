get '/sessions/new' do
	erb :'sessions/new'
end

post '/sessions' do
	email, password = params[:email], params[:password]
	user = User.authenticate(email, password)
	user ? process_authentication(user) : failed_authentication
end

delete '/sessions' do
	flash[:notice] = 'Goodbye!'
	session[:user_id] = nil
	redirect to('/')
end