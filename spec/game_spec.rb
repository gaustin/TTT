require 'spec_helper'

describe Game do
  before(:each) do
    @game = Game.new
    @x_player = NaivePlayer.new('X')
    @o_player = NaivePlayer.new('O')
  end

	it "should let a player take a turn" do
		move = @game.turn_for(@x_player)
		move.should_not be_nil
	end

	it "should report that the game is finished" do
	  @game.board.rows.each_with_index do |row, y|
	    row.each_with_index do |cell, x|
	      @game.board.move('X', [x, y])
	    end
	  end
		@game.complete?.should be_true
	end

	it "should report that the game is not finisished" do
		@game.complete?.should be_false
	end

	describe "determining a winner" do
	  it "should report a column winner" do
  	  @game.board.move(@x_player.mark, [0, 0])
  	  @game.board.move(@x_player.mark, [0, 1])
  	  @game.board.move(@x_player.mark, [0, 2])
  		@game.winner(@x_player, @y_player).should == @x_player.mark
  	end
  	
  	it "should report a row winner" do
  	  @game.board.move(@x_player.mark, [0, 0])
  	  @game.board.move(@x_player.mark, [1, 0])
  	  @game.board.move(@x_player.mark, [2, 0])
  		@game.winner(@x_player, @y_player).should == @x_player.mark
  	end
  	
  	it "should report a diagonal winner" do
  	  @game.board.move(@x_player.mark, [0, 0])
  	  @game.board.move(@x_player.mark, [1, 1])
  	  @game.board.move(@x_player.mark, [2, 2])
  		@game.winner(@x_player, @y_player).should == @x_player.mark
  	end
  end
end
