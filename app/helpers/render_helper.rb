
module RenderHelper
  def render_ok(data = {})
    data.merge!({
      :ok => true
    }).to_json
  end


  def render_err(e)
    $logger.error e.to_hash
    
    status 400

    e.to_hash.merge(:ok => false).to_json
  end


  def render_page(items, count)
    {
      :ok => true,
      :items => items,
      :count => count,
      :count_pages => (count.to_f / paging_args[:perpage]).ceil,
      :current_page => paging_args[:page],
      :perpage => paging_args[:perpage]
    }.to_json
  end
end
