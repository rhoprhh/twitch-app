require 'bundler'
require 'date'
#require 'open-uri'
require 'pry'
require 'sqlite3'
require 'active_record'
Bundler.require(:default)

$: << "."
require_relative '../lib/models/db.rb'
require_relative '../lib/models/users.rb'
require_relative '../lib/models/scraper.rb'
require_relative '../lib/models/inputs.rb'


DB = ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database => "../db/users"
    )

    DB = ActiveRecord::Base.connection

    if ENV['ACTIVE_RECORD+ENV'] == 'test'
      ActiveRecord::Migration.verbose = false
    end
#require_relative '../db/users.db'
#require '/db/*'
