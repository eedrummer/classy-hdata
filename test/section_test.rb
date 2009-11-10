require 'test/test_helper'

class SectionTest < HDataTest
  context "A section of an hData Record" do
    setup do
      DataMapper.auto_migrate!
      
      extension = Extension.new(:type_id  => 'http://projecthdata.org/hdata/schemas/2009/06/allergy', :requirement => 'mandatory')
      extension.save
      section = Section.new(:name => 'Allergies', :path => 'allergies')
      section.extension = extension
      section.save
    end
    
    should 'return an ATOM feed at the root' do
      get '/allergies'
      assert last_response.ok?
    end
    
  end
end