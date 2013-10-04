
require File.expand_path('../../config/environment.rb', __FILE__)


module Sky; class App < Sinatra::Base
  use Rack::Session::Dalli
  set :views, File.expand_path('app/views', SKY_PATH)


  helpers SessionHelper
  helpers PagingArgsHelper
  helpers RenderHelper




  before do
    return if params.length > 0

    params.merge!(JSON(env['rack.input'].read)) rescue nil
  end


  
  class << self
    def rackup_root
      @rackup_root ||= '/' + self.name.underscore.gsub(/_controller$/, '')
    end


    def set_rackup_root(path)
      @rackup_root = path
    end
  end
  
end; end
