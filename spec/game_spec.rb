require 'spec_helper'

describe Game do
  before(:each) do
    @game = Game.new
    @x_player = NaivePlayer.new('X')
    @o_player = NaivePlayer.new('O')
  end

	it "should let a player take a turn" do
		move = @game.turn_for(@x_player, @o_player)
		move.should_not be_nil
	end

	it "should report that the game is finished" do
	  9.times do |i|
	    @game.turn_for(@x_player, @o_player)
	  end
		@game.complete?.should be_true
	end

	it "should report that the game is not finisished" do
		@game.complete?.should be_false
	end

	describe "determining a winner" do
	  it "should report a column winner" do
  	  player_one = double('player')
  	  player_one.stub(:mark) { "X" }
  	  player_one.stub(:play) { [0, 0] }
  	  @game.turn_for(player_one, @o_player)
  	  player_one.stub(:play) { [0, 1] }
  	  @game.turn_for(player_one, @o_player)
  	  player_one.stub(:play) { [0, 2] }
  	  @game.turn_for(player_one, @o_player)
  		@game.winner.should == player_one.mark
  	end
  	
  	it "should report a row winner" do
  	  player_one = double('player')
  	  player_one.stub(:mark) { "X" }
  	  player_one.stub(:play) { [0, 0] }
  	  @game.turn_for(player_one, @o_player)
  	  player_one.stub(:play) { [1, 0] }
  	  @game.turn_for(player_one, @o_player)
  	  player_one.stub(:play) { [2, 0] }
  	  @game.turn_for(player_one, @o_player)
  		@game.winner.should == player_one.mark
  	end
  	
  	it "should report a diagonal winner" do
  	  player_one = double('player')
  	  player_one.stub(:mark) { "X" }
  	  player_one.stub(:play) { [0, 0] }
  	  @game.turn_for(player_one, @o_player)
  	  player_one.stub(:play) { [1, 1] }
  	  @game.turn_for(player_one, @o_player)
  	  player_one.stub(:play) { [2, 2] }
  	  @game.turn_for(player_one, @o_player)
  		@game.winner.should == player_one.mark
  	end
  end
end
