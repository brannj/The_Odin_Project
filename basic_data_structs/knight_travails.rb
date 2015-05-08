Move = Struct.new(:position, :path)

def knight_moves(start, finish)
  start_time = Time.now
  move = Move.new(start)
  queue = []
  visited = [start]
  until move.position == finish
    next_moves(move.position).each do |next_move|
      unless visited.include?(next_move)
        visited << move
        queue.push(Move.new(next_move, move))
      end
    end
    move = queue.shift
  end
  time_taken = Time.now - start_time
  print_path(move, time_taken)
end

def next_moves(new_move)
  possibles = [[-2, -1], [-2, 1], [-1, 2], [-1, -2],
                    [1, 2], [1, -2], [2, 1], [2, -1]]
  potential_moves = possibles.map do |possible|
    (0..1).map { |coord| possible[coord] + new_move[coord] }
  end
  potential_moves.select { |move| valid_move?(move)}
end

def valid_move?(move)
  (move[0] > -1 || move[0] < 8) &&
  (move[1] > -1 || move[1] < 8)
end

def print_path(move, time_taken)
  path_taken = [move.position]
  until move.path.nil?
    path_taken << move.path.position
    move = move.path
  end

  puts "You made it in #{path_taken.size - 1} moves and #{time_taken} seconds!  Here's your path:"
  path_taken.reverse.each { |move| p move }
end

test = knight_moves([3,3], [5,5])
