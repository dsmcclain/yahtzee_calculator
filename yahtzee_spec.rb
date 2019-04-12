require_relative 'yahtzee.rb'

describe Game do
  before :each do
    @game = Game.new([1,3,5,2,4], 1, {})
  end

  it 'should initialize class variables' do
    expect(@game.dice).to eq([1,3,5,2,4])
    expect(@game.roll_count).to eq(1)
    expect(@game.multiples).to eq({})
  end

  it 'should organize dice into a hash' do
    @game.organize_dice
    expect(@game.multiples).to eq({1=>1, 2=>1, 3=>1, 4=>1, 5=>1})
  end
end