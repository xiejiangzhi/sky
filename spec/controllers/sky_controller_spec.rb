require 'spec_helper'


describe SkyController do
  before :each do
    SpecApp.app = SkyController
  end

  describe 'index' do
    it 'default' do
      get '/'
      last_response.should be_ok
    end
  end


  describe 'template' do
    it 'index' do
      get '/template/index'
      last_response.should be_ok
    end

    it 'no found' do
      get '/template/no_found_alsdjf'
      last_response.should be_not_found
    end
  end



  describe 'stylesheets' do
    it 'existed file' do
      get '/stylesheets/sky.css'
      last_response.should be_ok
    end


    it 'not css file' do
      get '/stylesheets/sky'
      last_response.should be_not_found
    end


    it 'not found file' do
      get '/stylesheets/no_found_alsdjf.css'
      last_response.should be_not_found
    end
  end

end
