SECONDS_IN_HOUR = 3600

get '/users/new' do
	@user = User.new
	erb :'users/new'
end

post '/users' do
	@user = User.create(:email => params[:email],
										 :password => params[:password],
										 :password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		send_welcome_message_to(@user)
		flash[:notice] = 'Welcome'
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :'users/new'
	end
end

get '/users/forgotten_password' do
	erb :'users/forgotten_password'
end

post '/users/reset_password' do
	user = User.first(:email => params[:email])
	if user
		save_token_for(user)
		send_password_reset_message_to(user)
		flash[:notice] = 'A password reset email is on its way'
		redirect to('/')
	else
		flash[:errors] = ['Your details could not be found']
		redirect to('/')
	end
end

get '/users/reset_password/:token' do |token|
	@token = token
	@user = User.first(:password_token => token)
	if @user && Time.parse(@user.password_token_timestamp) > (Time.now - SECONDS_IN_HOUR)
		erb :'users/reset_password' 
	else
		erb :'users/reset_error'
	end
end

post '/users/confirm_reset_password' do
	user = User.first(:password_token => params[:token])
	if user
		set_new_password_for(user, params[:new_password], params[:new_password_confirmation])
		flash[:notice] = 'Your password has been reset'
		redirect to('/')
	else
		flash[:errors] = ['Your token has expired or is invalid']
		redirect to('/')
	end
end