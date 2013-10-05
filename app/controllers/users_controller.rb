
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
  post '/login' do
    user_info = {
      :username => params[:username],
      :email => params[:email]
    }

    user = User.where(user_info).first
    user = User.create!(user_info) unless user

    if user.role == User::ADMIN
      unless user.valid_pwd(params[:password])
        user = User.guest
      end
    end

    set_current_user user

    render_ok :username => user.username
  end


  post '/logout' do
    session.clear

    render_ok
  end
end
