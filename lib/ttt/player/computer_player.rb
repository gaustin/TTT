#TODO: Don't like the 3x3 assumptions
class ComputerPlayer < Player
  
  def play(board, opponent)
    # FTW
    return if play_two_in_a_row(board, @mark)
    
    # Prevent the win
    return if play_two_in_a_row(board, @mark, opponent.mark)
    
    return if block_or_create_fork(board, @mark, opponent.mark)
    
    # Center
    return board.move(@mark, [1, 1]) if board.unmarked_spaces.include?([1, 1])
    
    # Opponent in opposing corner? Play opposite corner.
    return if play_opposing_corner(board, opponent.mark)
    
    # Empty corner? Play it.
    return if play_empty_corner(board)
    
    # Empty middle square on a side? Play it.
    return if play_middle_side(board)
  end
  
  def play_opposing_corner(board, opposing_mark)
    # Get the list of corners claimed by the other user
    opposing_corners = board.marked_spaces(opposing_mark).reject do |cell|
      !Board::CORNERS.include?(cell)
    end
    
    # All corners are taken
    return if opposing_corners.empty? || opposing_corners.size >= 4
    
    unmarked_spaces = board.unmarked_spaces
    opposing_corners.each do |cell|
      opposite_corner = Board::OPPOSITE_CORNERS[cell]
      return board.move(@mark, opposite_corner) if unmarked_spaces.include?(opposite_corner)
    end
    nil
  end
  
  def play_middle_side(board)
    Board::MID_SIDES.each do |cell|
      if board.unmarked_spaces.include?(cell)
        board.move(@mark, cell)
        return cell
      end
    end
    nil
  end
  
  def play_empty_corner(board)
    Board::CORNERS.each do |corner|
      if board.unmarked_spaces.include?(corner)
        board.move(@mark, corner)
        return corner
      end
    end
    nil
  end
  
  def play_two_in_a_row(board, mark, opponent_mark=nil)
    target_mark = opponent_mark.nil? ? mark : opponent_mark
    
    board.rows.each_with_index do |row, y|
      if row.select { |cell| cell == target_mark }.size == 2
        row.each_with_index do |cell, x|
          return board.move(mark, [x, y]) if board[x, y].nil?
        end
      end
    end
    
    board.columns.each_with_index do |column, x|
      if column.select { |cell| cell == target_mark }.size == 2
        column.each_with_index do |cell, y|
          return board.move(mark, [x, y]) if board[x, y].nil?
        end
      end
    end
    board.diagonals.each do |diagonal|
      values_for_mark = diagonal.select { |coord| board[coord.first, coord.last] == target_mark }
      if values_for_mark.size == 2
        moves = diagonal - values_for_mark
        return board.move(mark, moves.first) if moves.size == 1
      end
	  end
    nil
  end
  
  def block_or_create_fork(board, mark, opponent_mark=nil)
    
  end
end

#Block opponent's fork:
    #Option 1: Create two in a row to force the opponent into defending, as long as it doesn't result in them creating a fork or winning. 
             # For example, if "X" has a corner, "O" has the center, and "X" has the opposite corner as well, "O" must not play a corner in order to win. (Playing a corner in this scenario creates a fork for "X" to win.)
    #Option 2: If there is a configuration where the opponent can fork, block that fork.
