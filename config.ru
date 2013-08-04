
require File.expand_path('../config/application', __FILE__)

use Rack::Static, :urls => ['/public']


map '/blog' do
  run Sky::Blog
end


map '/' do
  run Sky::App
end
