require_relative 'yahtzee.rb'

describe Game do
  before(:context) do
    @game = Game.new([1,2,3,4,5], 1, {})
  end

  it 'should initialize class variables' do
    expect(@game.dice).to eq([1,2,3,4,5])
    expect(@game.roll_count).to eq(1)
    expect(@game.multiples).to eq({})
  end

  it 'should sort dice numerically' do
    @game.sort_dice(54321)
    expect(@game.dice).to eq([1,2,3,4,5])
    @game.sort_dice(13321)
    expect(@game.dice).to eq([1,1,2,3,3])
    @game.sort_dice(12345)
    expect(@game.dice).to eq([1,2,3,4,5])
  end

  it 'should organize dice into a hash' do
    @game.organize_dice
    expect(@game.multiples).to eq({1=>1, 2=>1, 3=>1, 4=>1, 5=>1})
  end

  it 'should identify straights correctly' do
    @game.organize_dice
    expect(@game.three_in_a_row?).to be true
    expect(@game.four_in_a_row?).to be true
    expect(@game.five_in_a_row?).to be true
  end
end