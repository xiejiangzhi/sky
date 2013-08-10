

SKY_USER_PATH = File.expand_path('../../', __FILE__)



module Sky; class User < Sinatra::Base
  set :views, File.expand_path('app/views', SKY_USER_PATH)
end; end




require File.expand_path('app/models', SKY_USER_PATH)
require File.expand_path('app/helpers', SKY_USER_PATH)
require File.expand_path('app/controllers', SKY_USER_PATH)
