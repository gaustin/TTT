class NaivePlayer < Player
  # This guy is so naive he just randomly picks.
  def play(board, opponent)
    choice = board.unmarked_spaces[rand(board.unmarked_spaces.size)]
    board.move(mark, choice)
  end
end