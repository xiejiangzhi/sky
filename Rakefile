
task :console do
  require 'pry'
  
  require File.expand_path('../app/sky', __FILE__)

  binding.pry
end


task :setup do
  require File.expand_path('../app/sky', __FILE__)

  config = YAML.load_file('config/application.yml')

  User.find_or_create_by({
    :username => config['admin']['username'],
    :email => config['admin']['email'],
    :password => config['admin']['password'],
    :role => User::ADMIN
  })
end
