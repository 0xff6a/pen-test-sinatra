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
		Mailer.send_message(@user.email, "Welcome to the Bookmark Manager", 
		"Hey Good Lookin',\n\nWelcome to the bookmark manager.\n\nAll the best,\n\nThe Team")
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
	user.update(:password_token => generate_token, :password_token_timestamp => Time.now)
	Mailer.send_message(user.email, "Password Reset", 
		"Click here to reset your password: 
		http://localhost:9292/users/reset_password/#{user.password_token}")
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
	user.update(:password => params[:new_password],
							:password_confirmation => params[:new_password_confirmation],
							:password_token => nil,
							:password_token_timestamp => nil)
	"DONE"
end