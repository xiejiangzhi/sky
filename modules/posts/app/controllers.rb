
module Sky; class Post < Sinatra::Base
  before do
    return if params.length > 0

    params.merge!(JSON(env['rack.input'].read)) rescue nil
  end


  get '/' do
    page = paging_args

    posts = Models::Post.all.skip(page[:skip]).limit(page[:limit])

    render_page posts, Models::Post.count
  end


  get '/show' do
    post = Models::Post.find(params[:id])

    render_ok post
  end



  post '/create' do
    post = Models::Post.create!({
      :title => params[:title],
      :content => params[:content]
    })

    render_ok :post => post
  end


  post '/update' do
    post = Models::Post.find(params[:id])

    post.update_attributes({
      :title => params[:title],
      :content => params[:content]
    })

    render_ok
  end
end; end
