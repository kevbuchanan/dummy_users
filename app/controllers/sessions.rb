enable :sessions

get '/login' do
  erb :sign_in
end

post '/login' do
  @user = User.authenticate(params[:user][:email], params[:user][:password])
  if @user
    session[:user_id] = @user.id
    redirect to('/')
  else
    @error = "Invalid login"
    erb :sign_in
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect to ('/')
end
