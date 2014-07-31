class Link
	
	include DataMapper::Resource

	belongs_to :user
	has n, :tags, :through => Resource

	property :id, 					Serial
	property :title, 				String, :required => true, 
																	:message => 'A title must be provided'
	property :url, 					String, :format => :url, 
																	:message => 'Invalid URL format', 
																	:required => true,
																	:message => 'A URL must be provided' 
	property :timestamp,		String
	property :description, 	Text

end