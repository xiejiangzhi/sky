
class SkyController < Sky::App

  helpers TagHelper

  set_rackup_root '/'



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


end
