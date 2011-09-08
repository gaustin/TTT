require 'spec_helper'

describe HumanPlayer do
  it "should let the player make a mark" do
    board = double('board')
    board.stub(:unmarked_spaces) { [[1,1]] }
    
    output = double('output')
    output.should_receive(:puts).with(board.to_s)
    output.should_receive(:puts).with("X player, choose a position (type 'choices' for a list valid moves): ")
    
    input = double('input')
    input.stub(:gets) { '1,1' }
    
    player = HumanPlayer.new("X", input, output)
    choice = player.play(board, NaivePlayer.new("0"))
    choice.should == [1,1]
  end
end