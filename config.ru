
require File.expand_path('../config/application', __FILE__)

use Rack::Static, :urls => ['/public']


map '/posts' do
  run Sky::Post
end


map '/users' do
  run Sky::User
end


map '/' do
  run Sky::App
end
