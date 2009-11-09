require 'classy-hdata'

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!

Sinatra::Application.run!