require 'vendor/gems/environment'

Bundler.require_env(:test)

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