require 'dotenv/load'
require 'bundler'

Bundler.require
require 'securerandom'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)

#require './app/controllers/application_controller'
require_all 'app'