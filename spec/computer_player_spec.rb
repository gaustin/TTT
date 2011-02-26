require 'spec_helper'

describe ComputerPlayer do
	before(:each) do
		@x_player = ComputerPlayer.new('X')
		@o_player = ComputerPlayer.new('0')
		@game = Game.new
		@board = Board.new(3, 3)
	end

  it "should go for the win when it has two in a row" do
    @board.move(@x_player.mark, [0, 0])
    @board.move(@x_player.mark, [1, 0])
    @x_player.play(@board, @o_player)
    @board[2, 0].should == 'X'
  end
  
  it "should go for the win when it has two in a column" do
    @board.move(@x_player.mark, [0, 0])
    @board.move(@x_player.mark, [0, 1])
    @x_player.play(@board, @o_player)
    @board[0, 2].should == 'X'
  end
  
  it "should go for the win when it has two in a diagonal" do
    @board.move(@x_player.mark, [0, 0])
    @board.move(@x_player.mark, [1, 1])
    @x_player.play(@board, @o_player)
    @board[2, 2].should == 'X'
  end
  
  it "should make a mark in and empty corner" do
    @x_player.play_empty_corner(@board)
    Board::CORNERS.any? do |corner|
      !@board[corner.first, corner.last].nil?
    end.should be_true
  end
  
  it "should make a mark in a cell in the middle of a side" do
    @x_player.play_middle_side(@board)
    Board::MID_SIDES.any? do |side|
      !@board[side.first, side.last].nil?
    end.should be_true
  end
  
  it "should make a mark in a cell in an opposing corner" do
    @board[0, 0] = @o_player.mark
    @x_player.play_opposing_corner(@board, @o_player.mark)
    @board[2, 2].should == @x_player.mark
  end
  
  it "should play the center when it doesn't have two in a row" do
    @game.turn_for(@x_player, Player.new('O'))
    @game.board.marked_spaces.should include [1, 1]
  end
end
