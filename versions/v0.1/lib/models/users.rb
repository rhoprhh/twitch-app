class Users < ActiveRecord::Base
  attr_accessor :username, :url, :follower_count, :last_game_played, :last_stream_title,
                :creation_date, :logo, :display_name, :total_views, :total_views,
                :partner_boolean, :following_count, :timestamp

  @@all = []

  def initialize(username)
    @username = username
    info = Scraper.new(username, nil)
    info.scrape_following
    info.scrape_channel
    #binding.pry
    @follower_count = info.channel_hash["followers"]
    @last_game_played = info.channel_hash["game"]
    @last_stream_title = info.channel_hash["status"]
    @creation_date = info.channel_hash["created_at"][0...10]
    @logo = info.channel_hash["logo"]
    @display_name = info.channel_hash["display_name"]
    @total_views = info.channel_hash["views"]
    @partner_boolean = info.channel_hash["partner"]
    @following_count = info.following_hash["_total"]
    @timestamp = Time.new
    @@all << self
    #binding.pry
  end



  # def insert
  #   db=SQLite3::Database.new('db/users.db')
  #   db.results_as_hash = true
  #   q = "SELECT username,timestamp FROM users WHERE username = ? AND id = (SELECT MAX(id) FROM users WHERE username = ?)"
  #   result = db.execute(q, @username, @username)
  #   binding.pry
  #   #query = "INSERT INTO users (username, follower_count, last_game_played, last_stream_title, creation_date, logo, display_name, total_views, partner_boolean, following_count, timestamp) VALUES (?,?,?,?,?,?,?,?,?,?,?);
  #   query = "INSERT INTO users (username, follower_count, last_game_played, last_stream_title, creation_date, logo, display_name, total_views, partner_boolean, following_count, timestamp) VALUES (?,?,?,?,?,?,?,?,?,?,?);"
  #   db.execute(query, @username, @follower_count, @last_game_played, @last_stream_title, @creation_date, @logo, @display_name, @total_views, @partner_boolean.to_s, @following_count, @timestamp.to_s)
  # end

  # def self.push_user_to_db
  #    if NAME EXISTS IN INDEX TABLE && TIMESTAMP FROM AN OLDER DAY
  #      add stats to table
  #      update timestamp in index TABLE
  #    elsif NAME EXISTS IIT && LAST UPDATE WAS TODAY
  #      puts "no update for you"
  #    else
  #      ADD TO RELATIONAL TABLE, ADD TIMESTAMP
  #      CREATE USER TABLE
  #      INSERT NEW DATA
  #    end
  #  end

end
