
# spec_args:
#   path:
#   req_method:
#   req_params:
#   req_session:
#   creator: Proc.new {|i| Model.create(:name => "name#{i}") }
#

module SpecModules; module Paging
  extend RSpec::Core::SharedContext


  describe 'paging' do
    before :each do
      100.times {|i| spec_args[:creator].call(i) }
    end



    it 'default' do
      send_test_req spec_args[:req_params]
      last_response.should be_ok

      data = JSON(last_response.body)
      data['ok'].should == true
      data['items'].count.should == 10
      data['current_page'].should == 1
      data['count_pages'].should == 10
      data['perpage'].should == 10
    end


    it 'paging' do
      args = spec_args[:req_params].merge(:page => 2, :perpage => 15)
      send_test_req args
      last_response.should be_ok

      data = JSON(last_response.body)
      data['ok'].should == true
      data['items'].count.should == 15
      data['current_page'].should == 2
      data['count_pages'].should == 7
      data['perpage'].should == 15
    end


    it 'last page' do
      args = spec_args[:req_params].merge(:page => 2, :perpage => 60)
      send_test_req args
      last_response.should be_ok

      data = JSON(last_response.body)
      data['ok'].should == true
      data['items'].count.should == 40
      data['current_page'].should == 2
      data['count_pages'].should == 2
      data['perpage'].should == 60
    end

    it 'one page' do
      args = spec_args[:req_params].merge(:page => 1, :perpage => 600)
      send_test_req args
      last_response.should be_ok

      data = JSON(last_response.body)
      data['ok'].should == true
      data['items'].count.should == 100
      data['current_page'].should == 1
      data['count_pages'].should == 1
      data['perpage'].should == 600
    end
  end
end; end
