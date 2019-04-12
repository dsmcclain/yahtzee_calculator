require_relative 'yahtzee.rb'

describe Game do
  before :each do
    @game = Game.new
  end

  it 'should initialize class variables' do
    expect(@game.dice).to be_nil
    expect(@game.multiples).to be_nil
    expect(@game.roll_count).to be_nil
  end
end