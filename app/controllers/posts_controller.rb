
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



  # show
  #
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



  # create
  #
  # Params:
  #   title:
  #   content:
  # Return:
  #   ok: true of false
  #   post: if true
  post '/create' do; begin
    post = Post.create!({
      :title => params[:title],
      :content => params[:content],
      :user => current_user
    })

    render_ok :post => post
  rescue => e
    render_err e
  end; end



  # update
  #
  # Params:
  #   id:
  #   title:
  #   content:
  # Return:
  #   ok: true or false
  post '/update' do; begin
    post = Post.find(params[:id])

    post.update_attributes({
      :title => params[:title],
      :content => params[:content],
      :language => params[:language]
    })

    render_ok
  rescue => e
    render_err e
  end; end




  # answer
  #
  # Params:
  #   target_id:
  #   content:
  # Return:
  #   ok: true or false
  #   answer: {_id: xxx}
  post '/answer' do; begin
    post = Post.find(params[:target_id])

    answer = post.posts.create({
      :content => params[:content],
      :language => params[:language],
      :user => current_user
    })

    render_ok :answer => answer
  rescue => e
    render_err e
  end; end




  # answer_list
  #
  # Params:
  #   target_id:
  #   page:
  #   perpage:
  # Return:
  #   ok: true or false
  #   items: 
  get '/answer_list' do; begin
    post = Post.find(params[:target_id])
    page = paging_args

    answers = post.posts.skip(page[:skip]).limit(page[:limit])

    render_page answers, post.posts.count
  rescue => e
    render_err e
  end; end
end
