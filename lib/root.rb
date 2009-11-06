# Handles all requests to the root of the HRF

get '/' do
  @extensions = Extension.all
  erb :index
end

put '/' do
  status 405
  "You can't PUT at this level of the hData Record"
end

post '/' do
  check_params
  handle_extension if params[:type].eql?('extension')
  handle_section if params[:type].eql?('section')
end

def check_params
  unless ['extension', 'section'].include? params[:type]
    halt 400, "Your request must specify a type of either section or extension"
  end
end

def handle_extension
  extension = Extension.new(:type_id  => params[:typeId], :requirement => params[:requirement])
  if extension.valid?
    extension.save
    status 201
  else
    if extension.errors.full_messages.include? "Extension with that type id already exists"
      halt 409, "Extension with that type id already exists"
    else
      halt 400, extension.errors.full_messages.join(' ')
    end
  end
end

def handle_section
  extension = Extension.first(:type_id => params[:typeId])
  if extension
    section = Section.new(:name => params[:name], :path => params[:path])
    section.extension = extension
    if section.valid?
      section.save
      status 201
    else
      if section.errors.full_messages.include? "A section already exists at that path"
        halt 409, "A section already exists at that path"
      else
        halt 400, section.errors.full_messages.join(' ')
      end
    end
  else
    halt 400, "Couldn't find the extension for the typeId specified"
  end
end