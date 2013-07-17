enable :sessions

get '/' do
  erb :index
end

get '/success' do
end

post '/create' do
  @user = User.new(params[:user])
  if @user.valid?
    @user.save
    redirect to('/success')
  else
    redirect to('/')
  end
end

post '/login' do
end
