require 'classy-hdata'

DataMapper.setup(:default, "sqlite3:db/development.sqlite3")
DataMapper.auto_upgrade!

Sinatra::Application.run!