class HumanPlayer < Player
  def prompt(board)
    puts board.to_s
    puts "#{@mark} player, choose a position (type 'choices' for a list valid moves): "
  end
  
  def play(board, opponent)
    options = board.unmarked_spaces
    while true
      prompt(board)
  	  choice = STDIN.gets.chomp
  	  if choice.downcase == 'choices'
  	    p options
  	  else
  	    begin
  	      x, y = choice.chomp.split(",").collect { |c| c.to_i}
  	      if options.include?([x, y])
  	        return [x, y]
    	    else
    	      puts "\nInvalid choice. Try again.\n"
  	      end
	      rescue TypeError
	        puts "Bad format. Enter positions in X,Y format."
          prompt(board)
        end
  	  end
	  end
  end
end