get %r{/(\w+)/(\d+)} do |section_path, document_id|
  section = Section.first(:path => section_path)
  if section
    document = section.documents.get(document_id.to_i)
    if document
      document.content
    else
      status 404
    end
  else
    status 404
  end
end