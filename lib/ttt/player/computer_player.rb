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
    opposing_corners = board.marked_spaces(opposing_mark).find_all do |cell|
      Board::CORNERS.include?(cell)
    end
    
    # All corners are taken
    return if opposing_corners.empty? || opposing_corners.size >= 4
    
    #TODO: Are opposing corners really just diagonals? In TTT all corners are opposing, in a way.
    
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

    diagonals = board.diagonals
    if board[1, 1] == mark
      # try to block a fork
      fork_to_block = diagonals.select do |diagonal| 
        diagonal.count { |cell| cell == opponent_mark } == 2
      end
      play_middle_side(board) unless fork_to_block.nil?
    elsif [1, 1] == opponent_mark
      # try to create fork
      fork_to_create = diagonals.select do |diagonal|
        diagonal.count { |cell| cell == mark } == 2
      end
      play_middle_side(board) unless fork_to_create.nil?
    end
  end
end
