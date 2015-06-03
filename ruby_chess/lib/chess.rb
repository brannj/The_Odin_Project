# Player moves are variable.
# Game piece positions and play is variable.
# Piece moves are fixed.
#
# player interacts with board.
#   chooses from-to move.
# board interacts with the pieces.
#
# game controls game play:
#   checks if game has ended
#   returns any errors.
#   takes turns.
# Store pieces in a Hash.

module Chess

  def self.game
    @game = ChessGame.new
  end

  class ChessGame
    attr_reader :board, :turn

    def initialize
      @board = Board.new
      @turn = 'White'

    end

    def play
      game_over if game_over?
      turn unless game_over?
    end

    def turn

    end
  end

  class Board

    attr_reader :board, :turn, :pawn, :rook, :knight, :bishop, :queen, :king

    def initialize
      @board = set_up
      @pawn = Pawn.new
      @rook = Rook.new
      @knight = Knight.new
      @bishop = Bishop.new
      @queen = Queen.new
      @king = King.new
    end

    def set_up
      # Upper case for white, lower case for black.
      { a1: 'R', b1: 'N', c1: 'B', d1: 'Q',
        e1: 'K', f1: 'B', g1: 'N', h1: 'R',
        a2: 'P', b2: 'P', c2: 'P', d2: 'P',
        e2: 'P', f2: 'P', g2: 'P', h2: 'P',
        a3: '', b3: '', c3: '', d3: '',
        e3: '', f3: '', g3: '', h3: '',
        a4: '', b4: '', c4: '', d4: '',
        e4: '', f4: '', g4: '', h4: '',
        a5: '', b5: '', c5: '', d5: '',
        e5: '', f5: '', g5: '', h5: '',
        a6: '', b6: '', c6: '', d6: '',
        e6: '', f6: '', g6: '', h6: '',
        a7: 'p', b7: 'p', c7: 'p', d7: 'p',
        e7: 'p', f7: 'p', g7: 'p', h7: 'p',
        a8: 'r', b8: 'n', c8: 'b', d8: 'q',
        e8: 'k', f8: 'b', g8: 'n', h8: 'r' }
    end

    def turn

    end

    def player_turn
      @turn == 'White' ? 'Black' : 'White'
    end

    def show

    end
  end

  class Piece
    attr_reader :start, :finish, :moves
    def initialize(start = nil, finish = nil)
      @start = start
      @finish = finish
    end

    def to_coord
      coord = self.split("")
      coord[0], coord[1] = coord[0].ord, coord[1].to_i
      coord
    end

    def move_limits

    end

    def moves

    end
  end

  class Pawn < Piece
    LIMITS = [[0, 1], [0, 2]]
    
    ATTACK = [[1, 1], [-1, 1]]

    def moves

    end
  end

  class Rook < Piece
    LIMITS = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
              [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7],
              [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
       [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]]

    def moves

    end
  end

  class Knight < Piece
    LIMITS = [[-2, -1], [-2, 1], [-1, 2], [-1, -2],
              [1, 2], [1, -2], [2, 1], [2, -1]]

    def moves

    end
  end

  class Bishop < Piece
    LIMITS = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
              [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
       [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7],
       [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]]
  end

  class Queen < Piece
    LIMITS = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
              [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7],
              [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
       [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7],
                     [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
                     [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
              [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7],
              [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]]
  end

  class King < Piece
    LIMITS = [[0, 1], [1, 1], [1, 0], [1, -1], [-1, -1], [0, -1], [-1, 1]]
    CASTLE = [[2, 0], [-2, 0]]
  end

end

game = Chess.game
p game
p Chess::Queen::LIMITS
