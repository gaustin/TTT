class CheaterPlayer < Player
  def play(board, opponent)
    unmarked_spaces = board.unmarked_spaces
    unmarked_spaces.each do |space|
      board.move(@mark, space)
    end
  end
end