class Player
  attr_reader :mark
  
  def initialize(mark)
    @mark = mark
  end
  
	def play(board, opponent)
		raise NotImplementedError
	end
end
