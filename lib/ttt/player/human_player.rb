class HumanPlayer < Player
  def initialize(mark, input_stream=STDIN, output_stream=STDOUT)
    super(mark)
    @output_stream = output_stream
    @input_stream = input_stream
  end
  
  def prompt(board)
    @output_stream.puts board.to_s
    @output_stream.puts "#{@mark} player, choose a position (type 'choices' for a list valid moves): "
  end
  
  def play(board, opponent)
    options = board.unmarked_spaces
    while true
      prompt(board)
  	  choice = @input_stream.gets.chomp
  	  if choice.downcase == 'choices'
  	    p options
  	  else
  	    begin
  	      x, y = choice.chomp.split(",").collect { |c| c.to_i}
  	      if options.include?([x, y])
  	        return [x, y]
    	    else
    	      @output_stream.puts "\nInvalid choice. Try again.\n"
  	      end
	      rescue TypeError
	        @output_stream.puts "Bad format. Enter positions in X,Y format."
          prompt(board)
        end
  	  end
	  end
  end
end