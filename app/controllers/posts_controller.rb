
class PostsController < Sky::App

  helpers FilterHelper

  before /create|update/ do
    auth_permissio_filter
  end
  


  get '/' do
    page = paging_args

    posts = Post.all.skip(page[:skip]).limit(page[:limit])

    render_page posts, Post.count
  end


  get '/show' do
    post = Post.find(params[:id])

    render_ok post.attributes
  end



  post '/create' do
    post = Post.create!({
      :title => params[:title],
      :content => params[:content]
    })

    render_ok :post => post
  end


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
