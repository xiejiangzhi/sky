
module SessionHelper

  def current_user
    @_user ||= User.find_user(session[:user_id])
  end



  def set_current_user(user)
    session[:user_id] = user.id.to_s
    @_user = user
  end
end
