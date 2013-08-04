
module Sky; class Blog < Sinatra::Base; helpers do
  def paging_args
    perpage = params[:perpage].to_i
    perpage = 10 if perpage == 0

    page = params[:page].to_i || 1

    args = {:limit => perpage}
    args[:skip] = (page - 1) * perpage if page > 1

    args
  end



  def format_posts(posts)
    posts.each do |post|
      post['id'] = post.delete('_id').to_s
    end
  end
end; end; end
