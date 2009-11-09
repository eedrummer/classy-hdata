require 'test/test_helper'

class RootTest < HDataTest
  context "The root of an hData Record" do
    setup do
      DataMapper.auto_migrate!
    end
    
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
        extension = Extension.first(:type_id => 'http://projecthdata.org/hdata/schemas/2009/06/allergy')
        assert extension
        assert_equal 'mandatory', extension.requirement
      end
      
      should "not allow the registration of a duplicate extension" do
        Extension.new(:type_id  => 'http://projecthdata.org/hdata/schemas/2009/06/allergy', :requirement => 'mandatory').save
        post '/', {:type => 'extension', :typeId => 'http://projecthdata.org/hdata/schemas/2009/06/allergy', 
                   :requirement => 'mandatory'}
        assert_equal 409, last_response.status
      end
      
      should "allow the creation of a new section" do
        Extension.new(:type_id  => 'http://projecthdata.org/hdata/schemas/2009/06/allergy', :requirement => 'mandatory').save
        post '/', {:type => 'section', :typeId => 'http://projecthdata.org/hdata/schemas/2009/06/allergy', 
                   :path => 'allergies', :name => 'Allergies'}
        assert_equal 201, last_response.status
      end
    end
    
    should "provide a root.xml document describing the extensions and sections" do
      extension = Extension.new(:type_id  => 'http://projecthdata.org/hdata/schemas/2009/06/allergy', :requirement => 'mandatory')
      extension.save
      section = Section.new(:name => 'Allergies', :path => 'allergies')
      section.extension = extension
      section.save
      
      get '/root.xml'
      assert last_response.ok?
      doc = Nokogiri::XML.parse(last_response.body)
      extension_element = doc.xpath('//hrf:root/hrf:extensions/hrf:extension[text()="http://projecthdata.org/hdata/schemas/2009/06/allergy"]', 
                                   {'hrf' => "http://projecthdata.org/hdata/schemas/2009/06/core"})
      assert !extension.empty?
      section_element = doc.xpath('//hrf:root/hrf:sections/hrf:section[@name="Allergies"]', {'hrf' => "http://projecthdata.org/hdata/schemas/2009/06/core"})
      assert !section_element.empty?
    end
  end
end