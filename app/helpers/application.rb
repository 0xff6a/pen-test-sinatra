helpers do

	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end

	def send_message(to, subject, message_body)
		  RestClient.post "https://api:#{ENV['MAILGUN_API_KEY']}"\
	  "@api.mailgun.net/v2/app27919871.mailgun.org/messages",
	  :from => "BookMarkManager <me@app27919871.mailgun.org>",
	  :to => to,
	  :subject => subject,
	  :text => message_body
	end

end
