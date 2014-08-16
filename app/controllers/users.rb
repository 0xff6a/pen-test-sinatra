SECONDS_IN_HOUR = 3600

get '/users/new' do
	@user = User.new
	erb :'users/new'
end

post '/users' do
	@user = create_user(params[:email], params[:password], params[:password_confirmation])
	@user.save ? process_new_user(@user) : failed_new_user(@user)
end

get '/users/forgotten_password' do
	erb :'users/forgotten_password'
end

post '/users/reset_password' do
	user = User.first(:email => params[:email])
	user ? process_password_reset_request_for(user) : failed_password_reset_request
end

get '/users/reset_password/:token' do |token|
	@token, @user = token, User.first(:password_token => token)
	if @user && valid_token_timestamp?(@user, SECONDS_IN_HOUR)
		erb :'users/reset_password' 
	else
		erb :'users/reset_error'
	end
end

post '/users/confirm_reset_password' do
	user = User.first(:password_token => params[:token])
	if user
		set_new_password_for(user, params[:new_password], params[:new_password_confirmation])
		password_reset_sucess
	else
		password_reset_error
	end
end