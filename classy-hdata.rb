require 'rubygems'
require 'sinatra'

# Set up the models
require 'dm-core'
require 'dm-validations'
require 'lib/models'

# Load the web request handlers
require 'erb'
require 'builder'
require 'lib/root'

START_TIME = Time.now