

SKY_POST_PATH = File.expand_path('../../', __FILE__)



module Sky; class Blog < Sinatra::Base
  set :views, File.expand_path('app/views', SKY_POST_PATH)
end; end




require File.expand_path('app/models', SKY_POST_PATH)
require File.expand_path('app/helpers', SKY_POST_PATH)
require File.expand_path('app/controllers', SKY_POST_PATH)
