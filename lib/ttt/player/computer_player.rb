class ComputerPlayer < Player
  def play(board)
    board.rows.each_with_index do |row|
      row.
    end
    
    open_spaces = board.unmarked_spaces
    my_spaces = board.marked_spaces(mark)
    
    # Take the center space if it's available
    return [1, 1] if open_spaces.size == board.size && open_spaces.index([1, 1])
    
		board.each_with_index do |row, y|
      # horizontals
      row.each_with_index do |cell, x|

      end
    	#(0..2).each do |x|
    	#		@board[x][y]
      #end
    end
    
    # TODO: GAME should take care of this case
    #take the last space if it's the only space available
  end
end

#Win: If the player has two in a row, play the third to get three in a row.
#Block: If the opponent has two in a row, play the third to block them.
#Fork: Create an opportunity where you can win in two ways.
#Block opponent's fork:
#Option 1: Create two in a row to force the opponent into defending, as long as it doesn't result in them creating a fork or winning. For example, if "X" has a corner, "O" has the center, and "X" has the opposite corner as well, "O" must not play a corner in order to win. (Playing a corner in this scenario creates a fork for "X" to win.)
#Option 2: If there is a configuration where the opponent can fork, block that fork.
#Center: Play the center.
#Opposite corner: If the opponent is in the corner, play the opposite corner.
#Empty corner: Play in a corner square.
#Empty side: Play in a middle square on any of the 4 sides.
