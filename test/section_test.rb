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
    
    should 'allow the POSTing of a section document' do
      upload_file = Rack::Test::UploadedFile.new(File.join(File.dirname(__FILE__), '..', 'fixtures', 'allergy1.xml'), 'application/xml')
      post '/allergies', {:type => 'document', :content => upload_file}
      assert_equal 201, last_response.status
      section = Section.first(:path => 'allergies')
      assert_equal 1, section.documents.count
      assert_equal "http://localhost:4567/allergies/#{section.documents.first.id}", last_response.body
    end
    
  end
end