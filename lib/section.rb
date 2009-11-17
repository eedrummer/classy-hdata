get %r{/([\w]+)/?} do |section_path|
  @section = Section.first(:path => section_path)
  if @section
    builder :section_atom
  else
    status 404
  end
end

post %r{/([\w]+)/?} do |section_path|
  @section = Section.first(:path => section_path)
  if @section
    doc = Document.new(:content => params[:content][:tempfile], :section => @section)
    doc.save
    status 201
    "http://localhost:4567/#{@section.path}/#{doc.id}"
  else
    status 400, "Could not find the section"
  end
end

delete %r{/([\w]+)/?} do |section_path|
  @section = Section.first(:path => section_path)
  if @section
    @section.documents.each do |document|
      document.destroy!
    end
    @section.destroy!
    status 204
  else
    status 404
  end
end