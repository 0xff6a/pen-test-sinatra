MAX_ATTEMPTS = 5

get '/sessions/new' do
	erb :'sessions/new'
end

post '/sessions' do
  
  session[:login_attempts] ||= 0

  raise 'Account Locked' if session[:login_attempts] > MAX_ATTEMPTS
	
  email, password = params[:email], params[:password]
	user = User.authenticate(email, password)
	user ? process_authentication(user) : failed_authentication
  
  session[:login_attempts] += 1
end

delete '/sessions' do
	flash[:notice] = 'Goodbye!'
	session[:user_id] = nil
	redirect to('/')
end