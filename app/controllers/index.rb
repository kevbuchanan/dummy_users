enable :sessions

get '/' do
  erb :index
end


before '/success' do
  redirect to('/') unless session[:user]
  @user = User.find(session[:user])
end

get '/success' do
  erb :success
end

post '/create' do
  @user = User.new(params[:user])
  if @user.valid?
    @user.save
    session[:user] = @user.id
    redirect to('/success')
  else
    erb :index
  end
end

post '/login' do
  @user = User.authenticate(params[:user][:email], params[:user][:raw_password])
  if @user
    session[:user] = @user.id
    redirect to('/success')
  else
    erb :index
  end
end

post '/logout' do
  session.delete(:user)
  redirect to ('/')
end
