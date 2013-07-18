get '/users/:id' do 
  @user = User.find(params[:id])
  @urls = @user.urls
  erb :user
end

post '/users/create' do
  @user = User.new(params[:user])
  if @user.valid?
    @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    erb :sign_in
  end
end
