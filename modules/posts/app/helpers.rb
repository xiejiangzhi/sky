
module Sky; class Post < Sinatra::Base

  helpers Helpers::PagingArgs
  helpers Helpers::RenderHelper

  helpers do
    def format_posts(posts)
      posts.each do |post|
        post['id'] = post.delete('_id').to_s
      end
    end
  end
end; end
