
require File.expand_path('../app/sky', __FILE__)

use Rack::Static, :urls => ['/public']


controller_dir = File.expand_path('app/controllers', SKY_PATH)
Sky::AutoloadDir.each_dir(controller_dir) do |basename, dir_path|
  ctrl_name = (dir_path + basename.gsub('.rb', '')).camelcase
  ctrl = ctrl_name.constantize

  map ctrl.rackup_root do
    run ctrl
  end
end
