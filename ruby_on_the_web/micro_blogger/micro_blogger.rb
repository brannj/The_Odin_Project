class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger"
  end

  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      assess_case(command, parts)
    end
  end

  def assess_case(command, parts)
    case command
    when 'q'
      puts "Goodbye!"
    when 't'
      tweet(parts[1..-1].join(" "))
    when 'dm'
      dm(parts[1], parts[2..-1].join(" "))
    when 'spam'
      spam_my_followers(parts[1..-1].join(" "))
    when 'elt'
      everyones_last_tweet
    else
      puts "Sorry, I don't know how to #{command}."
    end
  end

  def tweet(message)
    case
    when message.length > 140
      puts "Error: message greater than 140 characters."
    else
      puts message
    end
  end

  def dm(target, message)
    screen_names = followers_list
    puts "Trying to send #{target} this direct message:"
    puts message
    if screen_names.include?(target)
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "Cannot direct message @#{target}."
    end
  end

  def spam_my_followers(message)
    followers = followers_list
    followers.each do |follower|
      dm(follower, message)
    end
  end

  def followers_list
    %w[bert ernie cookie_monster elmo]
  end

  def everyones_last_tweet
    friends = @client.friends
    friends.each do |friend|
      # find each friend's last message.
      print @client.user(friend).screen_name
      print @client.user(friend).status.text
      puts "" # Blank line to separate friends.
    end
  end

end

blogger = MicroBlogger.new
blogger.run
