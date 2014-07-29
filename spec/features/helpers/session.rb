module SessionHelpers

	def sign_up(email = sample_email,
							password = sample_pwd,
							password_confirmation = sample_pwd)
		visit 'users/new'
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button 'Sign Up'
	end

	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email', :with => email
		fill_in 'password', :with => password
		click_button 'Sign In'
	end

	def create_user(email, password)
		User.create(:email => email,
								:password => password,
								:password_confirmation => password)
	end

end