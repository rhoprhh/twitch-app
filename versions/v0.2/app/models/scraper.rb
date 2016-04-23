class Scraper
   attr_accessor :username, :channel_hash, :following_hash, :follows_hash, :users_hash, :limit

  def initialize(username, limit)
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
  end
end
