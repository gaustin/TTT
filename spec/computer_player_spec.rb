require 'spec_helper'

describe ComputerPlayer do
	before(:each) do
		@player = ComputerPlayer.new('X')
#		@board = Board.new
	end

#	it "should choose an open position from the board" do

#	end
  
  it "should raise an error when initialized without a default mark" do
    lambda {
      Player.new
    }.should raise_error(ArgumentError)
  end
  
  it "should choose the middle space from an empty board" do
    board = Board.new(3, 3)
    choice = @player.play(board)
    choice.should == [1, 1]
  end
end
