class HumanPlayer
  def play(board)
    puts game.board.to_s
    puts "#{current_player.mark} player, choose a position (type 'help' for valid positions): "
  	choice = STDIN.gets.chomp
  	if choice.downcase == 'help'
  	  p game.board.unmarked_spaces
  	else
  	  x, y = choice.chomp.split(",").collect { |c| c.to_i}
  	end
  end
end