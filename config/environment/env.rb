

module Sky; class App < Sinatra::Base
  Dir.mkdir('logs') unless File.exist?('logs')

  $logger = Logger.new("logs/#{SKY_ENV}.log", 'weekly')
  $logger.level = Logger::INFO
end; end

require "./config/environment/#{SKY_ENV}"
