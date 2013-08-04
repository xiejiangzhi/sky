
autoload :YAML, 'yaml'


module Helpers
  autoload :PagingArgs, File.expand_path('lib/helpers/paging_args', SKY_PATH)
  autoload :RenderHelper, File.expand_path('lib/helpers/render_helper', SKY_PATH)
end
