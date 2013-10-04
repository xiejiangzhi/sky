
# default env, bundler
ENV['RACK_ENV'] ||= 'development'
SKY_ENV = ENV['RACK_ENV']

require 'bundler'
Bundler.require(:default, SKY_ENV)




require 'sinatra/base'
require 'rack/session/dalli'


SKY_PATH = File.expand_path('../../', __FILE__)




Mongoid.load!(File.expand_path('config/mongoid.yml', SKY_PATH))

require File.expand_path('lib/sky/autoload_dir', SKY_PATH)
require File.expand_path('config/autoload', SKY_PATH)
