

SKY_BLOG_PATH = File.expand_path('../../', __FILE__)



module Sky; class Blog < Sinatra::Base
  set :views, File.expand_path('app/views', SKY_BLOG_PATH)
end; end




require File.expand_path('app/models', SKY_BLOG_PATH)
require File.expand_path('app/helpers', SKY_BLOG_PATH)
require File.expand_path('app/controllers', SKY_BLOG_PATH)
