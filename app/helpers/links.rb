helpers do 

	def create_link(url, title, tags, description='')
		Link.create(:url => url, :title => title, 
								:tags => tags, :user_id => session[:user_id],
								:timestamp => Time.now,
								:description => description )
	end

	def create_tags(text)
		text.split(' ').map do |tag| 
			Tag.first_or_create(:text => tag, :user_id => session[:user_id]) 
		end
	end
	
end