
module UserAutoLoginHelper
  def user_auto_login
    return unless current_user.role == User::GUEST

    if params[:username] || params[:email]
      set_current_user(User.find_or_create_by({
        :username => params[:username],
        :email => params[:email]
      }))
    end
  end
end
