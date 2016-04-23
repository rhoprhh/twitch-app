class Scraper #< Users
   attr_accessor :username, :url, :follower_count, :last_game_played, :last_stream_title,
                 :creation_date, :logo, :display_name, :total_views, :total_views,
                 :partner_boolean, :following_count, :channel_hash, :following_hash,
                 :timestamp, :follows_hash, :users_hash, :limit

  #attr_reader :url_follows, :url_channel, :url_users, :url_following

  def initialize(username , limit)
    @username = username
    @limit = limit
    #pass only the username into methods so we generate the urls we need as we scrape them
    #dont call the next method here, use the object created in its place of creaton
    #to call further scraping methods class methods
  end

  def scrape_users
    url_users = 'https://api.twitch.tv/kraken/users/'+@username
    users_string = RestClient.get(url_users)
    @users_hash = JSON.parse(users_string)
  end

  def scrape_follows
    url_follows = 'https://api.twitch.tv/kraken/channels/'+@username+'/follows'
    follows_string = RestClient.get(url_follows)
    @follows_hash = JSON.parse(follows_string)
  end

  def scrape_channel
    url_channel = 'https://api.twitch.tv/kraken/channels/'+@username
    channel_string = RestClient.get(url_channel)
    @channel_hash = JSON.parse(channel_string)
  end

  def scrape_following
    url_following = 'https://api.twitch.tv/kraken/users/'+@username+'/follows/channels'
    following_string = RestClient.get(url_following)
    @following_hash = JSON.parse(following_string)
  end

  def scrape_top_games
    url_top_games = 'https://api.twitch.tv/kraken/games/top?limit=' + @limit.to_s
    games_string = RestClient.get(url_top_games)
    @games_hash = JSON.parse(games_string)
    #binding.pry
  end
  # def scrape_streams
  #   #follow_string = RestClient.get(@url_follows)
  #   #follow_hash = JSON.parse(follow_string)
  #   channel_string = RestClient.get(@url_channel)
  #   channel_hash = JSON.parse(channel_string)
  #   # users_string = RestClient.get(@url_users)
  #   # users_hash = JSON.parse(users_string)
  #   following_string = RestClient.get(@url_following)
  #   following_hash = JSON.parse(following_string)
  #
  #   @follower_count = channel_hash["followers"]
  #   @last_game_played = channel_hash["game"]
  #   @last_stream_title = channel_hash["status"]
  #   @creation_date = channel_hash["created_at"][0...10]
  #   @logo = channel_hash["logo"]
  #   @display_name = channel_hash["display_name"] #also users_hash["display_name"]
  #   @total_views = channel_hash["views"]
  #   @partner_boolean = channel_hash["partner"]
  #   @following_count = following_hash["_total"]
  #

  # users_hash["staff"] is a boolean for staff status


end
