begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

Bundler.require(:default)

require 'classy-hdata'

DataMapper.setup(:default, "sqlite3:db/development.sqlite3")
DataMapper.auto_upgrade!

Sinatra::Application.run!(:root => File.dirname(__FILE__))