require_relative 'helpers/session'

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
		User.create(:email => test_email,
								:password => test_pwd,
								:password_confirmation => test_pwd)
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
		User.create(:email => test_email,
								:password => test_pwd,
								:password_confirmation => test_pwd)
	end

	scenario 'while being signed in' do
		sign_in(test_email, test_pwd)
		click_button 'Sign Out'
		expect(page).to have_content('Goodbye!')
		expect(page).not_to have_content("Welcome, #{test_email}")
	end

end