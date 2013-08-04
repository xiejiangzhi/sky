
# default env, bundler
ENV['RACK_ENV'] ||= 'development'
SKY_ENV = ENV['RACK_ENV']

require 'bundler'
Bundler.require(:default, SKY_ENV)



require 'sinatra/base'


SKY_PATH = File.expand_path('../../', __FILE__)





require File.expand_path('config/autoload', SKY_PATH)
require File.expand_path('lib/db', SKY_PATH)




# load apps
require File.expand_path('app/sky', SKY_PATH)
require File.expand_path('modules/blog/config/application', SKY_PATH)

