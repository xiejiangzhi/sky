
class PostsController < Sky::App

  helpers FilterHelper

  before /create|update/ do
    auth_permissio_filter
  end
  


  # all posts
  # 
  # Params:
  #   page:
  #   perpage:
  # Return:
  #   ok:
  #   items:
  #   count_page:
  #   current_page:
  #   perpage:
  get '/' do
    page = paging_args

    posts = Post.all.skip(page[:skip]).limit(page[:limit])

    render_page posts, Post.count
  end



  # Params:
  #   id:
  # Return:
  #   id:
  #   title:
  #   content:
  #   created_at:
  #   updated_at:
  get '/show' do; begin
    post = Post.find(params[:id])

    render_ok post.attributes
  rescue => e
    render_err e
  end; end



  # Params:
  #   title:
  #   content:
  # Return:
  #   ok: true of false
  #   post: if true
  post '/create' do
    post = Post.create!({
      :title => params[:title],
      :content => params[:content]
    })

    render_ok :post => post
  end



  # Params:
  #   id:
  #   title:
  #   content:
  # Return:
  #   ok: true or false
  post '/update' do
    post = Post.find(params[:id])

    post.update_attributes({
      :title => params[:title],
      :content => params[:content],
      :language => params[:language]
    })

    render_ok
  end
end
