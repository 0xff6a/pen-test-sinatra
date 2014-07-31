class Link
	
	include DataMapper::Resource

	belongs_to :user
	has n, :tags, :through => Resource

	property :id, 				Serial
	property :title, 			String
	property :url, 				String, :format => :url, :message => 'invalid url format' 
	property :timestamp,	String

end