class Board

  attr_reader :board

  def initialize
    @board = Array.new(6) { (1..7).to_a }
  end

  def show
    print "\n "
    1.upto(7) { |i| print " #{i}" }
    print "\n"
    @board.reverse.each do |row|
      row.each do |col|
        print col.is_a?(Integer) ? " \u26d4" : col
      end
      print "\n"
    end
    print "\n"
  end

  def check_column?(move)
    column = []
    @board.any? do |row|
      row[move].is_a?(Integer)
    end
  end

  def store_move(move, piece)
    @board.each_with_index do |row, position|
      if row.include?(move)
        row[move - 1] = piece
        @row = position
        @column = move - 1
        @win = piece * 4
        return
      end
    end
  end

  def check_win?
    vertical_win? || horizontal_win? || diagonal_win?
  end

  def vertical_win?
    vertical = []
    @board.each do |row|
      vertical << row[@column]
    end
    vertical.join.include?(@win)
  end

  def horizontal_win?
    @board[@row].join.include?(@win)
  end

  def diagonal_win?
    diagonal1 || diagonal2
  end

  def diagonal1
    row1, column1 = @row, @column
    row2, column2 = @row - 1, @column - 1
    diagonal = []

    until (row1 > 5) || (column1 > 6)
      diagonal << @board[row1][column1]
      row1 += 1
      column1 += 1
    end

    until (row2 < 0) || (column2 < 0)
      diagonal.unshift(@board[row2][column2])
      row2 -= 1
      column2 -= 1
    end
    diagonal.join.include?(@win)
  end

  def diagonal2
    row1, column1 = @row, @column
    row2, column2 = @row + 1, @column - 1
    diagonal = []

    until (row1 < 0) || (column1 > 6)
      diagonal << @board[row1][column1]
      row1 -= 1
      column1 += 1
    end

    until (row2 > 5) || (column2 < 0)
      diagonal.unshift(@board[row2][column2])
      row2 += 1
      column2 -= 1
    end
    diagonal.join.include?(@win)
  end

  def full?
    moves_left = []
    @board.each do |row|
      row.each do |col|
        moves_left << "move" if col.is_a?(Integer)
      end
    end
    moves_left.empty? ? true : false
  end
end

#board = Board.new
#p board.show_board
#print board.full?
