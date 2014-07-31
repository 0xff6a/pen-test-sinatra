post '/users/favourites' do
	@link = Link.first(:id => params[:link_id])
	@user = User.first(:id => session[:user_id])
	Favourite.create(:user => @user, :link => @link)
	flash[:notice] = 'Added to favourites'
	erb :'users/favourites'
end

get '/users/favourites' do
	@user = User.first(:id => session[:user_id])
	erb :'users/favourites'
end