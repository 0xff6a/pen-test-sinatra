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
	user.password_token = (1..64).map{ ('A'..'Z').to_a.sample }.join
	user.password_token_timestamp = Time.now
	user.save!
	Mailer.send_message(user.email, "Password Reset", 
		"Click here to reset your password: http://localhost:9292/users/reset_password/#{user.password_token}")
end

get '/users/reset_password/:token' do

end