
module Sky; class App < Sinatra::Base
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





  helpers do
    def js_tag(path)
      "<script type='text/javascript' src='/public/#{path}'></script>"
    end


    def css_tag(path)
      "<link href='/public/#{path}' rel='stylesheet'>"
    end
  end

end; end
