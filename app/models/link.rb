class Link
	
	include DataMapper::Resource

	belongs_to :user
	has n, :tags, :through => Resource

	property :id, 				Serial
	property :title, 			String
	property :url, 				String, :format => :url
	property :timestamp,	String

end