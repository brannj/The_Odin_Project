class Game
  def initialize
    @game_choice
    choice
  end

  def choice
    puts "Would you like to make or break the code?"
    puts "Enter m for (m)ake, b for (b)reak or q to (q)uit: "
    @choice = gets.chomp.downcase
    start_game
  end

  def start_game
    case @choice
    when "m"
      @game_choice = CodeMaker.new
    when "b"
      @game_choice = CodeBreaker.new
    when "q"
      puts "Goodbye."
    else
      puts "Sorry, I could not understand that."
      choice
    end
  end
end


class CodeMaker
  def initialize
    @code_colors = %w[r g b w o p]
    @code = []
    @possible_solutions = @code_colors.repeated_permutation(4).to_a
    @feedback = []
    @round = 1
    make_code
    start
  end

  def make_code
    puts "Code pieces: (r)ed, (g)reen, (b)lue, (w)hite, (o)range, (purple)."
    print "Please enter a four piece code without spaces: "
    @code = gets.chomp.downcase.split("")
  end

  def start
    until @round > 12
      p @possible_solutions.size
      make_guess
      check_guess
      guess_logic
      p @possible_solutions.include?(@code)
      break if @feedback.count("b") == 4
      @round += 1
    end
    puts "Guessed in #{@round} rounds."
  end

  def make_guess
    if @round == 1
      @guess = %w[r r g g]
    else
      @guess = @possible_solutions.sample
    end
  end

  def check_guess
    @feedback = []
    puts "\nPlease provide feedback on the guess:"
    puts "    Code: #{@code.join(" ")}"
    puts "   Guess: #{@guess.join(" ")}"
    print "Feedback: "
    @feedback = gets.chomp.downcase.split("")
  end

  def guess_logic
    match_position if @feedback.include?("b")
    no_match if @feedback.empty?
    match_color if @feedback.include?("w")
  end

  def match_color
    if @feedback.count("w") == 3
      match_three
    elsif @feedback.count("w") == 2
      match_two
    else
      matches = @guess.repeated_permutation(@feedback.count("w")).to_a
      @possible_solutions = @possible_solutions.keep_if do |solution|
        matches.any? do |match|
          next if match.count(".") > 1
          solution.join.match(/#{match.join}/)
        end
      end
    end
  end

  def match_three
    @guess << "."
    matches = @guess.repeated_permutation(@feedback.count("w") + 1).to_a
    @possible_solutions = @possible_solutions.keep_if do |solution|
      matches.any? do |match|
        next if match.count(".") > 1
        solution.join.match(/#{match.join}/)
      end
    end
  end

  def match_two
    2.times { @guess << "." }
    matches = @guess.repeated_permutation(@feedback.count("w") + 2).to_a
    @possible_solutions = @possible_solutions.keep_if do |solution|
      matches.any? do |match|
        next if match.count(".") > 2
        solution.join.match(/#{match.join}/)
      end
    end
  end

  def no_match
    no_matches = @guess.uniq.each_slice(1).to_a
    @possible_solutions.reject! do |solution|
      no_matches.any? do |no_match|
        solution.join.include?(no_match.join)
      end
    end
  end

  def match_position
    @possible_solutions.reject! do |solution|
      count = 0
      @guess.each_with_index do |color, position|
        count += 1 if color == solution[position]
      end
      count != @feedback.count("b")
    end
  end
end


class CodeBreaker

  def initialize
    @code_colors = %w[r g b w o p]
    @code = @code_colors.sample(4)
    @guess = []
    start
  end

  def start
    12.times do
      make_guess
      check_guess
      break if @feedback.count("b") == 4
    end
    puts @code.join(" ")
  end

  def make_guess # should exist in Player class?
    print "Take your guess: "
    @guess = gets.chomp.downcase.split("")
  end

  def check_guess
    @feedback = []
    @check_code = @code.clone
    check_exact
    check_near
    puts "       Feedback: #{@feedback.join}"
  end

  def check_exact
    @guess.each_with_index { |color, position| exact(color, position) }
  end

  def check_near
    @guess.each_with_index { |color| near(color) }
  end

  def exact(color, position)
    if color == @check_code[position]
      @guess[position] = "-"
      @check_code[position] = "_"
      @feedback << "b"
    end
  end

  def near(guess_color)
    @check_code.each_with_index do |code_color, code_position|
      if code_color == guess_color
        @check_code[code_position] = "_"
        @feedback << "w"
        break
      end
    end
  end
end

class Board
  def initialize

  end
end

mastermind = Game.new
