
# default env, bundler
ENV['RACK_ENV'] ||= 'development'
SKY_ENV = ENV['RACK_ENV']

require 'bundler'
Bundler.require(:default, SKY_ENV)



require 'sinatra/base'
require 'rack/session/dalli'


SKY_PATH = File.expand_path('../../', __FILE__)



Mongoid.load!(File.expand_path('config/mongoid.yml', SKY_PATH))

require File.expand_path('config/autoload', SKY_PATH)




# load apps
require File.expand_path('app/sky', SKY_PATH)

require File.expand_path('modules/posts/config/application', SKY_PATH)
require File.expand_path('modules/users/config/application', SKY_PATH)

