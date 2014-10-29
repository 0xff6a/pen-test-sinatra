require 'bcrypt'

class User
	
	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password, :message => 'Sorry your passwords do not match'

	property :id, 											Serial
	property :email, 										String, :format => :email_address, 
																							:message => 'Invalid email format',
																							:unique => true, 
																							:message => 'This email is already taken'
	property :password_digest, 					Text
	property :password_token,						Text
	property :password_token_timestamp, String
	property :login_attempts,						Integer, :default => 0

	has n, :favourites
	has n, :links, through: :favourites

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(:email => email)
		return user if user && BCrypt::Password.new(user.password_digest) == password
		nil
	end

end