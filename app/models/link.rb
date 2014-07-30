class Link
	
	include DataMapper::Resource

	has n, :tags, :through => Resource

	property :id, 			Serial
	property :title, 		String
	property :url, 			String
	property :user_id,	Integer, :default => 0
end