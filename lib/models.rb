class Extension
  include DataMapper::Resource
  
  property :id, Serial
  property :type_id, String, :length => 200
  property :requirement, String
  
  validates_is_unique :type_id, :message => "Extension with that type id already exists"
  validates_format :requirement, :with  => /optional|mandatory/, :message => "Extension requirement must be optional or mandatory"
  validates_present :type_id, :requirement, :message => "An extension must specify a typeId and requirement"

  has n, :sections
end

class Section
  include DataMapper::Resource
  
  property :id, Serial
  property :path, String
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime
  
  validates_is_unique :path, :message => "A section already exists at that path"
  validates_present :name, :path, :message => "A section must specify a name and path"
  
  belongs_to :extension
  has n, :documents
end

class Document
  include DataMapper::Resource
  
  property :id, Serial
  property :content, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :section
end