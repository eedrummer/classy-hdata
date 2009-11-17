require 'test/test_helper'

class DocumentTest < HDataTest
  context "A document in an hData Record" do
    setup do
      DataMapper.auto_migrate!
      
      extension = Extension.new(:type_id  => 'http://projecthdata.org/hdata/schemas/2009/06/allergy', :requirement => 'mandatory')
      extension.save
      @section = Section.new(:name => 'Allergies', :path => 'allergies', :extension => extension)
      @section.save
      @document = Document.new(:content => "<allergy><product>Cheese</product><reaction>Hives</reaction></allergy>", :section => @section)
      @document.save
    end
    
    should "provide the document contents when issued a get request" do
      get "/#{@section.path}/#{@document.id}"
      assert last_response.ok?
      doc = Nokogiri::XML.parse(last_response.body)
      product_element = doc.xpath('//allergy/product[text()="Cheese"]')
      assert !product_element.empty?
    end
    
    should "be able to delete a document" do
      delete "/#{@section.path}/#{@document.id}"
      assert_equal 204, last_response.status
      assert_equal 0, @section.documents.count
    end
  end
end