class Section
  include DataMapper::Resource
  
  property :id, Serial
  property :path, String
  property :type_id, String
  property :name, String
  
  has n, :documents
end

class Document
  include DataMapper::Resource
  
  property :id, Serial
  property :contents, Text
  belongs_to :section
end