
# default env, bundler
ENV['RACK_ENV'] ||= 'development'
SKY_ENV = ENV['RACK_ENV']

require 'bundler'
Bundler.require(:default, SKY_ENV)




require 'sinatra/base'
require 'rack/session/dalli'


SKY_PATH = File.expand_path('../../', __FILE__)
Dir.chdir(SKY_PATH)





Mongoid.load!('config/mongoid.yml')


require './config/environment/env'
require './lib/sky/autoload_dir'
require './config/autoload'




require './lib/sky/error'
