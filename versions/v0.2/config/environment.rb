ENV['SINATRA_ENV'] ||= "development"

require 'sinatra'
require 'active_record'
require 'kappa'
require 'rest-client'
require 'pry'
require_relative '../app/models/users.rb'
require_relative '../app/models/scraper.rb'
require_relative '../app/models/inputs.rb'
require_relative '../app/models/games.rb'
require_relative '../app/models/sitegenerator.rb'
require_relative '../app/controllers/user_controller.rb'


connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
