module SetupHelpers

	def user
		User.first
	end

	def sign_up(email = sample_email,
							password = sample_pwd,
							password_confirmation = sample_pwd)
		visit '/users/new'
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

	def create_link(url, title, tag, user, description='')
		Link.create(:url => url, :title => title, 
								:tags => [Tag.first_or_create(:text => tag, :user_id => user.id)], 
								:user_id => user.id,
								:timestamp => Time.now,
								:description => description )
	end

	def add_link(url, title, tags = [], description='')
		visit '/links/new'
		within('#new-link') do
			fill_in 'url', :with => url
			fill_in 'title', :with => title
			fill_in 'tags', :with => tags.join(' ')
			fill_in 'description', :with => description
			click_button 'Add link'
		end
	end

end