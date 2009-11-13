get %r{/([\w]+)/?} do |section_path|
  @section = Section.first(:path => section_path )
  if @section
    builder :section_atom
  else
    status 404
  end
end