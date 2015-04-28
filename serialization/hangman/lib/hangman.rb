require 'yaml'
# Add a save game option to turns.
# Add a load game option to the initialisation.
class Hangman

  def initialize
    @word = select_word
    @guesses = []
    @progress = Array.new(@word.length, " _")
    welcome
  end

  def start
    puts "\nTry to guess the word by guessing letters."
    puts "If you make six incorrect guesses you lose."
    puts "Type 'save' to save the game and 'quit' to exit the game."
    until @guesses.size == 6 || !@progress.include?(" _")
      play
    end
    solution
  end

  private

  def welcome
    puts "\nWould you like to load an existing game or start a new game?"
    print "Type load or new: "
    game_options(gets.chomp.downcase)
  end

  def select_word
    dictionary = File.readlines("dictionary.txt").reject do |word|
      word.strip.length < 5 or word.strip.length > 12
    end
    dictionary.sample.downcase.strip.split("")
  end

  def play
    print "\n"
    puts @progress.join
    print_guesses
    @guess = make_guess
    check_letter
  end

  def check_letter
    if @word.include?(@guess)
      @word.each_with_index do |letter, position|
        @progress[position] = " #{letter}" if @guess == letter
      end
    else
      @guesses << @guess unless @guess.nil?
    end
  end

  def save_game
    Dir.mkdir("saved_games") unless Dir.exists? "saved_games"
    save_file = File.new("saved_games/hangman.yaml", "w")
    save = YAML::dump(self)
    save_file.write(save)
    save_file.close
    puts "Game saved."
  end

  def load_game
    load_file = File.open("saved_games/hangman.yaml", "r")
    load_game = load_file.read
    YAML::load(load_game).start
  end

  def quit_game
    puts "Goodbye.\n"
    exit
  end

  def game_options(choice)
    case choice
    when "load"
      load_game
    when "new"
      start
    else
      puts "That's not an option."
      welcome
    end
  end

  def print_guesses
    puts "Incorrect (#{6 - @guesses.size} left): #{@guesses.join(", ")}" unless @guesses.empty?
  end

  def solution
    puts " #{@word.join(' ')}"
  end

  def make_guess
    print "Make your guess: "
    guess_parser(gets.chomp.downcase)
  end

  def guess_parser(guess)
    if guess == "save"
      save_game
    elsif guess == "quit"
      quit_game
    elsif @guesses.include?(guess)
      puts "You have already tried that letter."
      make_guess
    elsif (/[a-z]/).match(guess) && guess.length == 1
      guess
    else
      puts "Please enter a single letter."
      make_guess
    end
  end


end

hangman = Hangman.new
