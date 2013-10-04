
module TagHelper
  def js_tag(path)
    "<script type='text/javascript' src='/public/#{path}'></script>"
  end


  def css_tag(path)
    "<link href='/public/#{path}' rel='stylesheet'>"
  end


  def less_tag(path)
    "<link href='/stylesheets/#{path}' rel='stylesheet'>"
  end
end
