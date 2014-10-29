MAX_ATTEMPTS = 3

get '/sessions/new' do
	erb :'sessions/new'
end

post '/sessions' do
  email, password = params[:email], params[:password]

  user = User.first(:email => email)
  user.update(:login_attempts => user.login_attempts + 1)

  if user && user.login_attempts > MAX_ATTEMPTS
    lock_account
  else
  	user = User.authenticate(email, password)
  	user ? process_authentication(user) : failed_authentication
  end

end

delete '/sessions' do
	flash[:notice] = 'Goodbye!'
	session[:user_id] = nil
	redirect to('/')
end

