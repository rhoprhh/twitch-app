class User < ActiveRecord::Base
  # attr_accessor :username, :follower_count, :last_game_played, :last_stream_title,
  #               :created_at, :logo, :display_name, :total_views, :total_views,
  #               :partner_boolean, :following_count, :timestamp

  def populate#(username)
    #@username = username
    info = Scraper.new(username, nil)
    info.scrape_following
    info.scrape_channel
    self.updated_at = info.channel_hash["updated_at"][0...19]
    self.follower_count = info.channel_hash["followers"]
    if info.channel_hash["game"] == nil
      self.last_game_played = "no games"
    else
      self.last_game_played = info.channel_hash["game"]
    end
    if info.channel_hash["status"] == nil
      self.last_stream_title = "Has Never Streamed Before"
    else
      self.last_stream_title = info.channel_hash["status"]
    end
    self.created_at = info.channel_hash["created_at"][0...10]
    if info.channel_hash["logo"] == nil
      self.logo = "https://i.imgur.com/tq7XYuC.png"
    else
      self.logo = info.channel_hash["logo"]
    end
    self.display_name = info.channel_hash["display_name"]
    self.total_views = info.channel_hash["views"]
    self.partner_boolean = info.channel_hash["partner"]
    self.following_count = info.following_hash["_total"]
    self.timestamp = Time.new
  end

  def self.create_populate_and_save(username: username)
    x = User.new(username: username)
    x.populate
    x.save
  end

  def pull_all_user_data
    User.where('username = ?', self.username)
  end



  def create_top_game_array
    hash = {}
    self.pull_all_user_data.map { |x| x.last_game_played }.each do |y|
      if hash[y].nil?
        hash[y] = 1
      else
        hash[y] +=1
      end
    end
    top_game = ["game",0]
    hash.each do |x|
      if top_game[1] < x[1]
        top_game[0] = x[0]
        top_game[1] = x[1]
      end
    end
    if top_game[0] == nil
      top_game << "no game"
    else
      top_game <<  Games.where('name = ?', top_game[0]).first.logo
    end
    top_game
  end

  def self.all_usernames
    output = []
    User.all.each do |x|
      output << x.username
    end
    output.uniq
  end

end
