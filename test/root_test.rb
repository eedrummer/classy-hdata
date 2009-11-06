require 'test/test_helper'

class RootTest < HDataTest
  context "The root of an hData Record" do
    should "return a response to a GET request" do
      get '/'
      assert last_response.ok?      
    end
    
    should "not allow a PUT" do
      put '/'
      assert_equal 405, last_response.status
    end
    
    context "when receiving a POST" do
      should "not allow an incomplete request" do
        post '/', {:type => 'extension'}
        assert_equal 400, last_response.status
      end
      
      should "allow the registration of a new extension" do
        post '/', {:type => 'extension', :typeId => 'http://projecthdata.org/hdata/schemas/2009/06/allergy', 
                   :requirement => 'mandatory'}
        assert_equal 201, last_response.status
      end
      
      should "allow the creation of a new section" do
        post '/', {:type => 'section', :typeId => 'http://projecthdata.org/hdata/schemas/2009/06/allergy', 
                   :path => 'allergies', :name => 'Allergies'}
        assert_equal 201, last_response.status
      end
    end
  end
end