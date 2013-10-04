


module Sky; module AutoloadDir; class << self
  def each_dir(dir, extname = '*.rb', &block)
    Dir[File.expand_path("**/#{extname}", dir)].each do |file_path|
      basename = File.basename(file_path)
      dir_path = file_path.split(dir).last.split(basename).first

      block.call(basename, dir_path, file_path)

    end
  end



  def namespace(name)
    md = Object
    name.split('::').each do |m|
      md = if md.const_defined? m
        md.const_get m
      else
        md.const_set(m, Module.new)
      end
    end

    md
  end
end; end; end


class Object
  def autoload_dir(dir)
    Sky::AutoloadDir.each_dir(dir) do |basename, dir_path, file_path|
      filename = basename.gsub('.rb', '')
      namespace = dir_path.gsub(/(^\/|\/$)/, '').camelcase
      ns = Sky::AutoloadDir.namespace(namespace)

      ns.autoload filename.camelcase.to_sym, file_path
    end
  end
end

