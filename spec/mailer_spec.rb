describe Mailer do
	
	it 'can send an email through mailgun' do
		expect(RestClient).to receive(:post).with("https://api:#{ENV['MAILGUN_API_KEY']}"\
		  "@api.mailgun.net/v2/#{ENV['MAILGUN_DOMAIN']}/messages",
		  {:from => "Bookmark Manager <me@#{ENV['MAILGUN_DOMAIN']}>", 
			:to => 'foxjerem@gmail.com',
			:subject => 'subject',
			:text => 'body'})																					
		Mailer.send_message('foxjerem@gmail.com', 'subject', 'body')
	end

end

