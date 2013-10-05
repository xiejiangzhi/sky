
module ArgumentsValidHelper
  def args_empty_valid(args)
    args.each do |name|
      val = params[name]
      raise Sky::ArgumentError.new(name, val) if val.nil? || val =~ /^\s*$/
    end
  end
end
