
require 'spec_helper'

describe UsersController do
  before :each do
    SpecApp.app = UsersController
  end


  describe 'index' do
    it 'not permission' do
      get '/'
      last_response.should be_bad_request
    end


    it 'admin' do
      user = get_user('admin', User::ADMIN)

      get '/', {}, valid_session(:user_id => user.id.to_s)
      last_response.should be_ok
    end
  end



  describe 'login' do
    before :each do
      @userinfo = {
        :username => 'test_user',
        :email => 'test@email.com'
      }
    end

    it 'auto create' do
      expect {
        post '/login', @userinfo
        last_response.should be_ok
      }.to change(User, :count).by(1)

      data = JSON(last_response.body)
      data['username'].should == @userinfo[:username]
    end



    it 'username + email valid' do
      User.create(@userinfo)

      expect {
        post '/login', @userinfo
        last_response.should be_ok
      }.to change(User, :count).by(0)

      data = JSON(last_response.body)
      data['username'].should == @userinfo[:username]
    end


    it 'admin login field, auto create guest' do
      pwd = '123123'
      User.create(@userinfo.merge(:password => pwd, :role => User::ADMIN))

      expect {
        post '/login', @userinfo
        last_response.should be_ok
      }.to change(User, :count).by(1)

      data = JSON(last_response.body)
      data['username'].should == User.where(:role => User::GUEST).first.username
    end


    it 'admin login field, exist guest' do
      pwd = '123123'
      User.create(@userinfo.merge(:password => pwd, :role => User::ADMIN))
      User.guest

      expect {
        post '/login', @userinfo
        last_response.should be_ok
      }.to change(User, :count).by(0)

      data = JSON(last_response.body)
      data['username'].should == User.where(:role => User::GUEST).first.username
    end


    it 'admin login ok' do
      pwd = '123123'
      User.create(@userinfo.merge(:password => pwd, :role => User::ADMIN))

      expect {
        post '/login', @userinfo.merge(:password => pwd)
        last_response.should be_ok
      }.to change(User, :count).by(0)

      data = JSON(last_response.body)
      data['username'].should == @userinfo[:username]
    end
  end



  describe 'logout' do
    it 'logout' do
      post '/logout'
      last_response.should be_ok
    end
  end
end
