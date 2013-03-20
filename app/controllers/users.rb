get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(params[:user])
  
  
  if @user.save
    set_sessions(@user)
    redirect "/profile"
  else
    # error handling
    erb :signup
  end
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    set_sessions(@user)
    redirect "/profile"
  else
    @error = "You need to supply an email and password that ACTUALLY match"
    erb :login
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/profile' do
  if session[:user_id] 
    @user = User.find(session[:user_id])
    erb :profile
  else
    redirect '/login'
  end
end
