#gets inputs

class Input

  attr_accessor :output

  def initialize
    @output = []
    5.times do puts "" end
    puts "Hey, who do you want to track?"
    puts "Please enter usernames 1-at-a-time."
    puts "when you are done then type either DONE or END"
    3.times do puts "" end
    user_input = gets.chomp
    until user_input.upcase == "DONE" || user_input.downcase == "end"
      if Twitch.channels.get(user_input).nil?
        puts "".rjust(5,'#')+" Invalid Username "+"".rjust(5,'#')
      else
        @output << user_input.downcase
      end
      user_input = gets.chomp
    end
    @output
  end




end
