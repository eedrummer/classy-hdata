xml.instruct! :xml, :version => '1.0'
xml.feed(:xmlns => "http://www.w3.org/2005/Atom") do
  xml.title(@section.name)
  xml.id("http://localhost:4567/" + @section.path)
  xml.updated(@section.updated_at.to_time.xmlschema)
  
  @section.documents.each do |document|
    xml.entry do
      xml.id("http://localhost:4567/#{@section.path}/#{document.id}")
      xml.title("#{@section.name} document #{document.id}")
      xml.updated(document.updated_at.to_time.xmlschema)
    end
  end
end