

require 'logger'

module Sky; class App < Sinatra::Base
  Dir.mkdir('logs') unless Dir.exist?('logs')

  $logger = Logger.new("logs/#{SKY_ENV}_out.log", 'weekly')
end; end

require "./config/environment/#{SKY_ENV}"
