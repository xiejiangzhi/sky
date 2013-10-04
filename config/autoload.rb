
autoload :YAML, 'yaml'


autoload_dir File.expand_path('lib', SKY_PATH)

autoload_dir(File.expand_path('app/controllers', SKY_PATH))
autoload_dir(File.expand_path('app/models', SKY_PATH))
autoload_dir(File.expand_path('app/helpers', SKY_PATH))


