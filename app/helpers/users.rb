helpers do

	def create_user(email, password, password_confirmation)
		User.create(:email => email,
								:password => password,
								:password_confirmation => password_confirmation)
	end

	def process_new_user(user)
		session[:user_id] = user.id
		flash[:notice] = 'Welcome'
		send_welcome_message_to(user)
		redirect to('/')
	end

	def failed_new_user(user)
		flash.now[:errors] = user.errors.full_messages
		erb :'users/new'
	end

	def process_authentication(user)
		session[:user_id] = user.id
		redirect to('/')
	end

	def failed_authentication
		flash[:errors] = ['The email or password is incorrect']
		erb :'sessions/new'
	end

	def process_password_reset_request_for(user)
		save_token_for(user)
		send_password_reset_message_to(user)
		flash[:notice] = 'A password reset email is on its way'
		redirect to('/')
	end

	def failed_password_request_reset
		flash[:errors] = ['Your details could not be found']
		redirect to('/')
	end

	def password_reset_sucess
		flash[:notice] = 'Your password has been reset'
		redirect to('/')
	end

	def lock_account
		flash[:errors] = ['Your account has been locked']
		redirect to('/')
	end

	def password_reset_error
		flash[:errors] = ['Your token has expired or is invalid']
		redirect to('/')
	end

	def send_welcome_message_to(user)
		Mailer.send_message(user.email, "Welcome to the Bookmark Manager", 
		"Hey Good Lookin',\n\nWelcome to the bookmark manager.\n\nAll the best,\n\nThe Team")
	end

	def send_password_reset_message_to(user)
		Mailer.send_message(user.email, "Password Reset", 
		"Click here to reset your password:\n http://salty-ravine-1138.herokuapp.com/users/reset_password/#{user.password_token}")
	end

	def set_new_password_for(user, new_password, new_password_confirmation)
		user.update(:password => new_password,
								:password_confirmation => new_password_confirmation,
								:password_token => nil,
								:password_token_timestamp => nil)
	end

	def save_token_for(user)
		user.update(:password_token => generate_token, :password_token_timestamp => Time.now)
	end

	def valid_token_timestamp?(user, validity_window)
		Time.parse(user.password_token_timestamp) > (Time.now - validity_window)
	end

end
