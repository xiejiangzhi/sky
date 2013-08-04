
module Sky; class User < Sinatra::Base
  get '/' do
    posts = USER.find({}, paging_args).to_a

    format_posts(posts).to_json
  end


  get '/show' do
    post = USER.find_one(BSON::ObjectId(params[:id]))

    format_posts([post]).first.to_json
  end


  # html
  get '/new' do
    slim :new
  end


  # html
  get '/edit' do
    @post = USER.find_one(BSON::ObjectId(params[:id]))

    slim :edit
  end



  post '/create' do
    Post.create(params)

    redirect to('/')
  end


  post '/update' do
    Post.update(params[:id], params)

    redirect to('/show?id=' + params[:id])
  end
end; end
