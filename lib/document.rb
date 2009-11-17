get %r{/(\w+)/(\d+)} do |section_path, document_id|
  section, document = find_document(section_path, document_id)
  document.content
end

put %r{/(\w+)/(\d+)} do |section_path, document_id|
  section, document = find_document(section_path, document_id)
  document.content = request.body.read
  document.save
  status 200
end

delete %r{/(\w+)/(\d+)} do |section_path, document_id|
  section, document = find_document(section_path, document_id)
  document.destroy!
  status 204
end

def find_document(section_path, document_id)
  section = Section.first(:path => section_path)
  if section
    document = section.documents.get(document_id.to_i)
    unless document
      halt 404
    end
  else
    halt 404
  end
  
  return section, document
end