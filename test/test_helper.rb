require 'classy-hdata'
require 'test/unit'
require 'rack/test'
require 'shoulda'

set :environment, :test

class HDataTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
  def test_truth
    assert true
  end
end