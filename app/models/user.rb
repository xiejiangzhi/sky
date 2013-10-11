
require 'digest'
require 'securerandom'

class User
  include Mongoid::Document


  # roles
  ADMIN   = 1
  COMMON  = 2
  GUEST   = 3

  # roles name
  ROLES_NAME = {
    ADMIN => 'Admin',
    COMMON => 'Common',
    GUEST => 'Guest'
  }


  field :username,        :type => String,  :default => ''
  field :email,           :type => String,  :default => ''
  field :role,            :type => Integer, :default => COMMON
  field :password_hash,   :type => String
  field :password_salt,   :type => String


  has_many :posts
  


  def valid_pwd(pwd)
    User.pwd_hash(pwd, password_salt || "") == password_hash
  end




  def password=(pwd)
    self.password_salt = User::rand_salt
    self.password_hash = User::pwd_hash(pwd, password_salt)
  end




  def can?(operat, resource)
    Sky::Permissions.new(self).can?(operat, resource)
  end




  REMOVE_KEYS = %w{password_hash password_salt}
  def to_json
    data = self.attributes.to_hash

    data[:role_name] = ROLES_NAME[data['role']]
    data.delete_if {|k, v| REMOVE_KEYS.include? k }

    data.to_json
  end

end




class User; class << self


  # id or unknow
  def find_user(user_id)
    where(:id => user_id).first || guest
  end



  def guest
    find_or_create_by(:username => 'Guest', :role => GUEST)
  end




  def pwd_hash(pwd, salt)
    Digest::SHA1.hexdigest((pwd || '') + salt)
  end


  def rand_salt
    SecureRandom.uuid
  end

end; end
