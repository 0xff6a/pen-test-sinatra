helpers do

	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end

	def generate_token
		(1..64).map{ random_char }.join
	end

	def random_char
		[('0'..'9').to_a, ('a'..'z').to_a, ('A'..'Z').to_a ].flatten.sample
	end

end
