require 'spec_helper'

describe Board do
  SIZE = 3
  
  before(:each) do
    @board = Board.new(SIZE, SIZE)
    @x_player = Player.new('X')
    @o_player = Player.new('O')
  end

  it "should report the list of unmarked spaces in an empty board" do
    @board.unmarked_spaces.size.should == SIZE * SIZE
  end
  
  it "should report the list of marked spaces in an empty board" do
    @board.marked_spaces.size.should == 0
  end
  
  it "should allow valid moves" do
    @board.valid_move?([1,1]).should == true
  end
  
  it "should accept valid moves" do
    @board.move(@x_player.mark, [1, 1])
    @board[1, 1].should == 'X'
    @board.unmarked_spaces.size.should == 8
  end
  
  it "should disallow invalid moves" do
    @board.move(@x_player.mark, [1, 1])
    @board.move(@o_player.mark, [1, 1])
  end
  
  it "should report a full board" do
    @board.rows.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        @board.move('X', [x, y])
      end
    end
    @board.full?.should be_true
  end
  
  it "should report an empty board" do
    @board.full?.should be_false
  end
  
  it "should report the values in a column" do
    values = @board.column(0)
    values.should == Array.new(3)
  end
  
  it "should report the values in a row" do
    values = @board.row(0)
    values.should == Array.new(3)
  end
end