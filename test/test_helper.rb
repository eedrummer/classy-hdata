begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

Bundler.require(:default, :test)

require 'classy-hdata'
require 'test/unit'

set :environment, :test
set :root, File.join(File.dirname(__FILE__), '..')

DataMapper.setup(:default, 'sqlite3::memory:')

class HDataTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
  def test_truth
    assert true
  end
end