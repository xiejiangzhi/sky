
module Sky; class App < Sinatra::Base
  use Rack::Session::Dalli
  
  set :views, File.expand_path('app/views', SKY_PATH)



  get '/' do
    slim :index
  end




  # TODO: cache
  get '/template/*' do
    p = params['splat'].first
    t = File.expand_path(p + '.slim', settings.views)

    if File.exist?(t)
      slim File.read(t), :layout => false
    else
      erb "no found template: '#{p}'"
    end
  end




  get '/stylesheets/*.css' do
    p = params['splat'].first
    t = File.expand_path("public/sky/css/#{p}.less", SKY_PATH)

    if File.exist?(t)
      less File.read(t), :layout => false
    else
      erb "no found stylesheets: '#{p}'"
    end
  end





  helpers do
    def js_tag(path)
      "<script type='text/javascript' src='/public/#{path}'></script>"
    end


    def css_tag(path)
      "<link href='/public/#{path}' rel='stylesheet'>"
    end


    def less_tag(path)
      "<link href='/stylesheets/#{path}' rel='stylesheet'>"
    end
  end

end; end
