
require 'digest'
require 'securerandom'

module Models; class User
  include Mongoid::Document


  field :username,        :type => String
  field :email,           :type => String
  field :password_hash,   :type => String
  field :password_salt,   :type => String


  def valid_pwd(pwd)
    self.class.pwd_hash(pwd, password_salt || "") == password_hash
  end

end; end


module Models; class User; class << self

  def create_by_pwd!(attrs, pwd)
    u = self.new(attrs)
    u.password_salt = rand_salt
    u.password_hash = pwd_hash(pwd, u.password_salt)

    u.save!

    u
  end



  def pwd_hash(pwd, salt)
    Digest::SHA1.hexdigest(pwd + salt)
  end


  def rand_salt
    SecureRandom.uuid
  end
end; end; end
