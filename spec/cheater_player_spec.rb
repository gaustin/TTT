require 'spec_helper'

describe CheaterPlayer do
  it "shouldn't be able to cheat" do
    game = Game.new
    game.turn_for(NaivePlayer.new('X'), NaivePlayer.new('O'))
    game.complete?.should be_false
  end
end