
module Sky; class User < Sinatra::Base
  use Rack::Session::Dalli

  get '/' do
    users = Models::User.all

    users.to_json
  end


  post '/login' do
    user_info = {
      :username => params[:username],
      :email => params[:email]
    }
    session.merge!(user_info)

    if params[:password]
      user = Models::User.where(user_info).first

      if user && user.valid_pwd(params[:password])
        session[:admin] = true
      end
    end

    session.to_json
  end


  post '/logout' do
    session.clear
  end
end; end
