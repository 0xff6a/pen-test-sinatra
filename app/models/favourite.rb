class Favourite

	include DataMapper::Resource

	belongs_to :user
	belongs_to :link

	property :id, Serial
	

end