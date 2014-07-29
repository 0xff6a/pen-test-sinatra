require_relative 'helpers/session'
require 'rest-client'

include SessionHelpers

feature 'User signs up' do
	
	let(:sample_email) { 'jeremy@example.com' }
	let(:sample_pwd)	 { '1234'								}

	scenario 'when being logged out' do
		expect { sign_up }.to change(User, :count).by(1)
		expect(page).to have_content("Welcome, #{sample_email}")
		expect(User.first.email).to eq(sample_email)
	end

	scenario 'with a password that does not match' do
		expect { sign_up('a@a.com', 'pass', 'wrong') }.to change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content('Sorry your passwords do not match')
	end

	scenario 'with an email that is already registered' do
		expect { sign_up }.to change(User, :count).by(1)
		expect { sign_up }.to change(User, :count).by(0)
		expect(page).to have_content('This email is already taken')
	end

end

feature 'User signs in' do

	let(:test_email) 	{ 'test@test.com' }
	let(:test_pwd)		{ 'test'					}

	before(:each) do
		create_user(test_email, test_pwd)
	end

	scenario 'with correct credentials' do
		visit '/'
		expect(page).not_to have_content("Welcome, #{test_email}")
		sign_in(test_email, test_pwd)
		expect(page).to have_content("Welcome, #{test_email}")
	end

	scenario 'with incorrect credentials' do
		visit '/'
		expect(page).not_to have_content("Welcome, #{test_email}")
		sign_in(test_email, 'wrong')
		expect(page).not_to have_content("Welcome, #{test_email}")
	end

end

feature 'User signs out' do

	let(:test_email) 	{ 'test@test.com' }
	let(:test_pwd)		{ 'test'					}

	before(:each) do
		create_user(test_email, test_pwd)
	end

	scenario 'while being signed in' do
		sign_in(test_email, test_pwd)
		click_button 'Sign Out'
		expect(page).to have_content('Goodbye!')
		expect(page).not_to have_content("Welcome, #{test_email}")
	end

end

feature 'User forgets password' do

	before(:each) do
		create_user('foxjerem@gmail.com', '1234')
	end

	scenario 'requesting a password reset' do
		expect(user.password_token).to be nil
		expect(user.password_token_timestamp).to be nil
		visit '/sessions/new'
		click_link('Forgotten password?')
		expect(page).to have_content('Enter your email to reset your password')
		fill_in 'email', :with => 'foxjerem@gmail.com'
		expect(Mailer).to receive(:send_message)
		click_button('Reset')
		expect(user.password_token).not_to be nil
		expect(user.password_token_timestamp).not_to be nil
	end

	scenario 'resetting the password' do
		user.update(:password_token => "test", :password_token_timestamp => Time.now)
		visit '/users/reset_password/test'
		expect(page).to have_content('Welcome foxjerem@gmail.com, enter a new password')
		fill_in 'new_password', :with => 'new'
		fill_in 'new_password_confirmation', :with => 'new'
		click_button 'Reset'
		expect(User.authenticate('foxjerem@gmail.com', 'new')).not_to be nil
	end

	scenario 'trying to reset the password with an invalid token' do
		user.update(:password_token => "test", :password_token_timestamp => Time.now)
		visit '/users/reset_password/not_the_right_token'
		expect(page).to have_content("Invalid Token")
	end

end
