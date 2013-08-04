
module Helpers; module RenderHelper
  def render_ok(json = {})
    json.merge!({
      :ok => true
    }).to_json
  end


  def render_err(json = {})
    status 400

    json.merge({
      :ok => false
    }).to_json
  end


  def render_page(items, count)
    {
      :ok => true,
      :items => items,
      :count => count,
      :current_page => paging_args[:page],
      :perpage => paging_args[:perpage]
    }
  end
end; end
