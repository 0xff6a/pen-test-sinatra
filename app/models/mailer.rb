class Mailer

		def self.send_message(to, subject, message_body)
			  RestClient.post "https://api:#{ENV['MAILGUN_API_KEY']}"\
		  "@api.mailgun.net/v2/#{ENV['MAILGUN_DOMAIN']}/messages",
		  :from => "BookMarkManager <me@#{ENV['MAILGUN_DOMAIN']}>",
		  :to => to,
		  :subject => subject,
		  :text => message_body
		end

end