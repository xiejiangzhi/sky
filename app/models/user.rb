
require 'digest'
require 'securerandom'

class User
  include Mongoid::Document


  # role
  ADMIN   = 1
  COMMON  = 2
  GUEST   = 3


  field :username,        :type => String,  :default => ''
  field :email,           :type => String,  :default => ''
  field :role,            :type => Integer, :default => COMMON
  field :password_hash,   :type => String
  field :password_salt,   :type => String


  def valid_pwd(pwd)
    User.pwd_hash(pwd, password_salt || "") == password_hash
  end




  def password=(pwd)
    self.password_salt = User::rand_salt
    self.password_hash = User::pwd_hash(pwd, password_salt)
  end




  def can?(operat, resource)
    return true if role == ADMIN

    return false
  end

end




class User; class << self


  # id or unknow
  def find_user(user_id)
    user = where(:id => user_id).first
    return user if user

    user = where(:username => 'Guest', :role => GUEST).first
    return user if user

    create(:username => 'Guest', :role => GUEST)
  end





  def pwd_hash(pwd, salt)
    Digest::SHA1.hexdigest((pwd || '') + salt)
  end


  def rand_salt
    SecureRandom.uuid
  end

end; end
