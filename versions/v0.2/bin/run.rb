require_relative '../config/environment.rb'
require 'pry'

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

binding.pry

usernames = Input.new
usernames.output.each do |x|
  usah = User.new(username: x)
  usah.populate
  usah2 = User.where('username = ?', x).last
    if usah2.nil?
      usah.save
    else
      if usah2.updated_at == usah.updated_at || usah.timestamp[0..9] == usah2.timestamp[0..9]
        3.times do puts "" end
          puts "profile has not been updated, not saved to DB"
          3.times do puts "" end
      else
        usah.save
      end
    end
  end


gen = SiteGenerator.new
gen.build_all_user_pages
gen.build_user_index
