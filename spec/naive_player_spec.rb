require 'spec_helper'

describe NaivePlayer do
  it "should make a move" do
    board = Board.new(3, 3)
    NaivePlayer.new('X').play(board)
    board.full?.should be_false
  end
end