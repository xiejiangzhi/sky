require 'spec_helper'

describe PostsController do
  before :each do
    SpecApp.app = PostsController
    
    # 100.times {|i| Post.create!(:title => "tt#{i}", :content => "cc#{i}") }
  end


  describe 'index' do
    let :spec_args do
      {
        :path => '/',
        :req_method => 'get',
        :req_params => {},
        :req_session => {},
        :creator => Proc.new {|i|
          Post.create(:title => "t#{i}", :content => "c#{i}")
        }
      }
    end

    include SpecModules::Paging

  

    it 'sort by created_at desc' do
      Post.create(:title => '111', :content => '111')
      sleep 1
      Post.create(:title => '222', :content => '222')

      send_test_req
      data = JSON(last_response.body)
      data['items'].first['title'].should == '222'
    end
  end



  describe 'show' do
    before :each do
      Post.create(:title => 'test t', :content => 'test c')
    end

    it 'default' do
      get '/show', :id => Post.first.id.to_s

      last_response.should be_ok

      data = JSON(last_response.body)
      data['title'].should_not == nil
      data['content'].should_not == nil
      data['created_at'].should_not == nil
      data['updated_at'].should_not == nil
    end


    it 'no found id' do
      get '/show', :id => 'no found id'

      last_response.should be_bad_request

      data = JSON(last_response.body)
      data['error'].should == Sky::RUNING_TIME_ERROR
      data['error_desc'].should_not == nil
    end
  end



  describe 'create' do
    it 'no permission' do
      expect {
        post '/create', :title => 'test t', :content => 'test c'

        last_response.should be_bad_request
        error_should(last_response, Sky::NoPermissionError.new)
      }.to change(Post, :count).by(0)
    end


    it 'by admin' do
      user = get_user('admin', User::ADMIN)
      req_args = {:title => 'test t', :content => 'test c'}

      expect {
        post '/create', req_args, valid_session(:user_id => user.id.to_s)

        last_response.should be_ok
      }.to change(Post, :count).by(1)

      data = JSON(last_response.body)
      data['ok'].should == true
      data['post']['_id'].should_not == nil
      data['post']['title'].should == 'test t'
      data['post']['content'].should == 'test c'
      data['post']['user_id'].should == user.id.to_s
    end
  end



  describe 'update' do
    before :each do
      @post = Post.create(:title => 'test t', :content => 'test c')
    end

    it 'no permission' do
      expect {
        post '/update', :title => 'tt', :content => 'cc', :id => @post.id.to_s

        last_response.should be_bad_request
        error_should(last_response, Sky::NoPermissionError.new)
      }.to change(Post, :count).by(0)
    end


    it 'by admin' do
      user = get_user('admin', User::ADMIN)
      req_args = {:title => 'tt', :content => 'cc', :id => @post.id.to_s}

      expect {
        post '/update', req_args, valid_session(:user_id => user.id.to_s)

        last_response.should be_ok
      }.to change(Post, :count).by(0)

      data = JSON(last_response.body)
      data['ok'].should == true
      @post.reload
      @post.title.should == req_args[:title]
      @post.content.should == req_args[:content]
    end
  end



  describe 'answer' do
    before :each do
      @post = Post.create(:title => 'top', :content => 'tc')
      @user = get_user('test user')
    end

    it 'default' do
      req_args = {:content => 'answer', :target_id => @post.id}
      expect {

        post '/answer', req_args, valid_session(:user_id => @user.id.to_s)
        last_response.should be_ok
      }.to change(Post.unscoped, :count).by(1)

      data = JSON(last_response.body)
      data['answer']['_id'].should_not == nil
      data['answer']['content'].should == 'answer'
      data['answer']['user_id'].should == @user.id.to_s
      @post.reload.posts.count.should == 1
    end
  end



  describe 'answer_list' do
    before :each do
      @post = Post.create(:title => 'top', :content => 'tc')
    end

    let :spec_args do
      {
        :path => '/answer_list',
        :req_method => 'get',
        :req_params => {:target_id => @post.id.to_s},
        :req_session => {},
        :creator => Proc.new {|i|
          @post.posts.create(:title => "t#{i}", :content => "c#{i}")
        }
      }
    end

    include SpecModules::Paging


    it 'sort by created_at desc' do
      @post.posts.create(:title => '111', :content => '111')
      sleep 1
      @post.posts.create(:title => '222', :content => '222')

      send_test_req(:target_id => @post.id.to_s)
      last_response.should be_ok

      data = JSON(last_response.body)
      data['items'].first['title'].should == '222'
    end
  end
end
