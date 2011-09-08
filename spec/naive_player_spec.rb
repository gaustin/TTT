require 'spec_helper'

describe NaivePlayer do
  it "should make a move" do
    game = Game.new
    game.turn_for(NaivePlayer.new('X'), NaivePlayer.new('O'))
    game.empty_board?.should be_false
  end
end