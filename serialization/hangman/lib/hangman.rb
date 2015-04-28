# Add a save game option to turns.
# Add a load game option to the initialisation.
class Hangman

  def initialize
    @word = select_word
    @guesses = []
    @progress = Array.new(@word.length, " _")
    start
  end

  def select_word
    dictionary = File.readlines("dictionary.txt").reject do |word|
      word.strip.length < 5 or word.strip.length > 12
    end
    dictionary.sample.downcase.strip.split("")
  end

  def start
    puts "Welcome. Try to guess the word by guessing letters."
    puts "If you make six incorrect guesses you lose."
    until @guesses.size == 6 || !@progress.include?(" _")
      play
    end
    solution
  end

  def play
    print "\n"
    @guess = make_guess

    check_letter

    puts @progress.join
    print_guesses
  end

  def check_letter
    if @word.include?(@guess)
      @word.each_with_index do |letter, position|
        @progress[position] = " #{letter}" if @guess == letter
      end
    else
      @guesses << @guess
    end
  end

  def save_game
    Dir.mkdir("saved_games") unless Dir.exists? "saved_games"
    save = File.new("hangman_save.yaml")
    yaml = YAML::dump(self)
    save.write(yaml)
  end

  def load_game

  end

  def print_guesses
    puts "Incorrect: #{@guesses.join(", ")}" unless @guesses.empty?
  end

  def solution
    puts " #{@word.join(' ')}" unless @guesses.size < 6
  end

  def make_guess
    print "Make your guess: "
    guess_parser(gets.chomp.downcase)
  end

  def guess_parser(guess)
    if guess == "save"
      save_game
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
