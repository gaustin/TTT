class Player
  attr_reader :mark
  
  def initialize(mark)
    @mark = mark
  end
  
	def play(board)
		raise NotImplementedError
	end
end
