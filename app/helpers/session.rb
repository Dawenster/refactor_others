helpers do 
  def set_sessions(user)
    give_token(user)
    session_user_id(user)
  end

  def give_token(user) # gives unique token to each user (see token.rb in models and token migration file)
    @token = Token.create( user_id: user.id, value: SecureRandom.hex(10) )
    session[:token] = @token.value
  end

  def session_user_id(user) # used to pass user id around for profile and other pages
    session[:user_id] = user.id
  end

  def current_user 
    # validate existence of user with the token
    @current_user ||= User.find( Token.find_by_value(session[:token]).user_id )
  end



end

