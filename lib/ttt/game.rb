class Game
	def initialize
		@board = Board.new(3, 3)
	end

	def turn_for(player, opponent)
	  choice = player.play(@board.dup, opponent)
		@board.move(player.mark, choice)
	end

	def complete?
		true if @board.full? || check_columns || check_rows || check_diagonals
	end

	def winner
		return check_columns || check_rows || check_diagonals || "nobody"
	end
	
	# TODO: How can we generalize 'triples' check for 'doubles' check?
	# TODO: Push these down into Board where they belong.
	def check_columns
	  @board.columns.each do |column|
	    first = column.first
	    return first unless column.any? { |value| value != first }
	  end
	  nil
	end
	
	def check_rows
	  @board.rows.each do |row|
	    first = row.first
	    return first unless row.any? { |value| value != first }
	  end
	  nil
	end
	
	def check_diagonals
	  @board.diagonals.each do |diagonal|
	    coordinate = diagonal.first
	    first = @board[coordinate.first, coordinate.last] 
	    return first unless diagonal.any? { |coord| @board[coord.first, coord.last] != first }
	  end
	  nil
	end
	
	def empty_board?
	  @board.empty?
	end
	
	def to_s
	  @board.to_s
	end
end
