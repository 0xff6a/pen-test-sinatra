MAX_ATTEMPTS = 3

get '/sessions/new' do
	erb :'sessions/new'
end

post '/sessions' do

  session[:login_attempts] ||= 0
  session[:login_attempts] += 1

  if session[:login_attempts] > MAX_ATTEMPTS
    lock_account
  else
    email, password = params[:email], params[:password]
  	user = User.authenticate(email, password)
  	user ? process_authentication(user) : failed_authentication
  end
  
end

delete '/sessions' do
	flash[:notice] = 'Goodbye!'
	session[:user_id] = nil
	redirect to('/')
end