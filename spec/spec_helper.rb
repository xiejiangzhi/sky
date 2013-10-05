
ENV['RACK_ENV'] = 'test'

require File.expand_path('../../app/sky', __FILE__)
require 'rspec'
require 'rack/test'

require 'helper_methods'


require 'rspec/core/shared_context'
spec_modules_path = File.expand_path('../spec_modules/*.rb', __FILE__)
Dir[spec_modules_path].each {|path| load path }




RSpec.configure do |config|
  config.before do
    Mongoid.purge!
  end
  

  config.include Rack::Test::Methods
  config.include HelperMethods

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end



class SpecApp; class << self
  attr_accessor :app
end; end


def app
  SpecApp.app
end

