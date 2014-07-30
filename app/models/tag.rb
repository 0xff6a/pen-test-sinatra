class Tag

	include DataMapper::Resource

	belongs_to :user
	has n, :links, :through => Resource

	property :id, 	Serial
	property :text, String

end