xml.instruct! :xml, :version => '1.0'
xml.root(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/core") do
  xml.documentId('1')
  xml.version('0.8')
  xml.created(START_TIME.strftime("%Y-%m-%d"))
  xml.lastModified(Time.now.strftime("%Y-%m-%d")) #hack
  xml.extensions do
    @extensions.each do |extension|
      xml.extension(extension.type_id, :requirement => extension.requirement)
    end
  end
  xml.sections do
    @extensions.each do |extension|
      extension.sections.each do |section|
        xml.section(:typeId => extension.type_id, :path => section.path, :name => section.name)
      end
    end
  end
  
end