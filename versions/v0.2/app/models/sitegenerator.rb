require 'erb'
class SiteGenerator

  attr_accessor :user, :hash

  def initialize
    @path = ''
  end

  def rendered_path
    @path
  end

  def build_index
  end

  def build_user_page(user, top_game)
    @user = user
    @top_game = top_game
    renderer = ERB.new(File.read('./app/views/users/show.html.erb'))
    htmlfile = File.new("./site/users/#{user.username}.html", "w")
    htmlfile.puts renderer.result(binding)
    htmlfile.flush
  end


  def build_user_index
    renderer = ERB.new(File.read('./app/views/users/index.html.erb'))
    htmlfile = File.new("./site/users/index.html", "w")
    htmlfile.puts renderer.result(binding)
    htmlfile.flush
  end

  def build_all_user_pages
    names = User.all_usernames
    names.each do |x|
      uzer = User.where("username = ?", x).last
      array=uzer.create_top_game_array
      gen = SiteGenerator.new
      gen.build_user_page(uzer, array)
    end
  end

end
