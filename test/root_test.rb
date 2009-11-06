require 'test/test_helper'

class RootTest < HDataTest
  context "The root of an hData Record" do
    should "return a response to a get request" do
      get '/'
      assert last_response.ok?      
    end
    
    should "not allow a put" do
      put '/'
      assert !last_response.ok?
      assert_equal 405, last_response.status      
    end
    
  end
end