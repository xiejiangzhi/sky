
require File.expand_path('../config/application', __FILE__)

use Rack::Static, :urls => ['/public']


map '/posts' do
  run Sky::Post
end


map '/' do
  run Sky::App
end
