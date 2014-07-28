require 'spec_helper'

feature 'User signs up' do
	
	scenario 'when being logged out' do
		expect { sign_up }.to change(User, :count).by(1)
		expect(page).to have_content('Welcome, jeremy@example.com')
		expect(User.first.email).to eq('jeremy@example.com')
	end

	scenario 'with a password that does not match' do
		expect { sign_up('a@a.com', 'pass', 'wrong') }.to change(User, :count).by(0)
	end

	def sign_up(email = 'jeremy@example.com',
							password = '1234',
							password_confirmation = '1234')
		visit 'users/new'
		expect(page.status_code).to eq 200
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button 'Sign Up'
	end

end