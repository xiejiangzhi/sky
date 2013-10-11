
class UsersController < Sky::App

  helpers FilterHelper

  before '/' do
    auth_permissio_filter
  end



  get '/' do
    users = User.all

    render_ok :items => users
  end



  # login
  #
  # Params:
  #   username:
  #   email:
  #   password: 可选
  # Return:
  #   role:
  #   
  post '/login' do; begin
    user_info = {
      :username => params[:username],
      :email => params[:email]
    }

    user = User.find_or_create_by(user_info)

    if user.role == User::ADMIN
      unless user.valid_pwd(params[:password])
        user = User.guest
      end
    end

    set_current_user user

    render_ok JSON(user.to_json)
  rescue => e
    render_err e
  end; end



  post '/logout' do
    session.clear

    render_ok
  end
end
