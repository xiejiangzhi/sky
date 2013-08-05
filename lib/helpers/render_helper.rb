
module Helpers; module RenderHelper
  def render_ok(data = {})
    data.merge!({
      :ok => true
    }).to_json
  end


  def render_err(data = {})
    status 400

    data.merge({
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
    }.to_json
  end
end; end
