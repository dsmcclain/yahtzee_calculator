=begin
Yahtzee Calculator
Program by Dylan McClain, June 2018
Current version September 2018

Please see ReadMe for an explanation of the calculator and
notes on future revisions.

Happy Rolling!
=end

require_relative 'Yahtzee_Probability_Calculations'

puts %q{Welcome to Yahtzee Calculator
        Enter your roll by just listing the numbers on the dice.
        Type 'exit' to exit.
        Happy rolling!}

class Game

    def initialize
        @dice = []
        @roll_count
        @multiples = {}
        @lg_straight
    end

    def start_game
        puts "\n~~~NEW TURN~~~"
        puts "What did you roll?"
        get_dice

        puts "How many rolls do you have left?"
        get_roll

        organize_dice
        parse_dice_and_check
    end

    def get_dice
        input = gets.chomp
        if input == 'exit'
            puts 'bye!'
            exit
        end

        @dice = input.to_i.digits.sort

        # Loop to check for valid inputs
        until @dice.length == 5 && @dice.all? {|x| x.between?(1,6)}
            puts "Hmmm...that can't be right"
            puts "What did you really roll?"
            @dice = gets.to_i.digits.sort
        end
    end

    def get_roll
        input = gets.chomp
        if input == 'exit'
            puts 'bye!'
            exit
        end

        @roll_count = input.to_i

        # Loop to check for valid inputs
        until @roll_count.between?(1,2)
            puts "Well, that's not right.\nIt's either 1 or 2. Which is it?"
            @roll_count = gets.to_i
        end
    end
    
    # Method to create two arrays, one for the numbers the user rolled
    # and one for the amount of times user rolled each number
    # then map these arrays into the hash @multiples.
    def organize_dice
        unique_numbers = @dice.uniq.each
        occurrences = []
        @dice.uniq.each { |n| occurrences << @dice.count(n)}
        @multiples = unique_numbers.zip(occurrences).to_h
    end

    #   Method to parse the hash @multiples and then call the methods that check for
    #   all the possible scenarios.
    def parse_dice_and_check
        singletons = @multiples.map { |k,v| v==1 ? k : nil }.compact
        pairs = @multiples.map { |k,v| v==2 ? k : nil }.compact
        triples = @multiples.map  { |k,v| v==3 ? k : nil }.compact
        quadruples =  @multiples.map { |k,v| v==4 ? k : nil }.compact
        yahtzees = @multiples.map { |k,v| v ==5 ? k : nil }.compact
        check_full_house(singletons, pairs, triples)
        check_yahtzee(singletons, pairs, triples, quadruples, yahtzees)
        check_straight
    end
    
    # Method to calculate probability of full house
    # SCENARIOS ARE: three of a kind or two pair
    def check_full_house(singletons, pairs, triples)
        if triples.any? && pairs.empty?
            chance = (((1.0/6.0) + (5.0/36.0)*(@roll_count-1))*100).truncate(2)
            puts "If you save your #{triples[0]}s along with your #{singletons.join(' or your ')}, your chance of rolling a full house is #{chance}%"
        elsif pairs.length == 2
            chance = (((1.0/3.0) + (10.0/36.0)*(@roll_count-1))*100).truncate(2)
            puts "If you save your two pairs your chance of rolling a full house is #{chance}%"
        elsif pairs.any? && triples.any?
            puts "You already have a full house!"
        end
    end

    # Method to calculate probability of yahtzee
    def check_yahtzee(singletons, pairs, triples, quadruples, yahtzees)
        if pairs.any?
            pairs.each { |pair| puts "You have a pair of " + pair.to_s + "s" }
            pairs_check(@roll_count)
        end

        if triples.any?
            puts "You already have three of a kind!"
            triples_check(@roll_count)
        end

        if quadruples.any?
            puts "You already have four of a kind!"
            chance = (((1.0/6.0) + (5.0/36.0)*(@roll_count-1))*100).truncate(2)
            puts "Your chance of rolling a YAHTZEE of #{quadruples[0]}s is #{chance}%"
        end
        
        if yahtzees.any?
            sleep(1)
            puts "wait"
            sleep(1)
            puts "wait a sec"
            sleep(1)
            puts "OMG YOU HAVE YAHTZEE!\nDID YOU NOT NOTICE?!\nSTOP ROLLING AND COLLECT UR POINTS!"
            sleep(2)
        end
    end

    # Method to identify straight draws and call appropriate methods
    # from Yahtzee_Probability_Calculations.rb
    def check_straight
        if five_in_a_row?
            puts "You already have a large straight!"
        elsif four_in_a_row?
            puts "You already have a small straight!"
            if (@multiples.keys & [1,6]).any?
                puts "If you save (#{@multiples.keys.join(',')}) "\
                      "your chance of rolling a large straight is #{straight_E(@roll_count)}%"
            else
                straight_F(@roll_count)
            end
        elsif three_in_a_row?
            if four_keepers_one_gap?
                straight_E(@roll_count)
            elsif (@multiples.keys & [1,6]).any?
                straight_A(@roll_count)
            else
                straight_D(@roll_count)
            end
        elsif three_keepers_one_gap?
            if (@multiples.keys & [1,6]).any?
                straight_A(@roll_count)
            else
                straight_B(@roll_count)
            end
        elsif three_keepers_two_gaps?
            straight_C(@roll_count)
        end
    end

    # Methods called by check_straight method
    def three_in_a_row?
        @multiples.keys.each_cons(3).any? { |a| a[2] - a[0] == 2 }
    end
    
    def four_in_a_row?
        @multiples.keys.each_cons(4).any? { |a| a[3] - a[0] == 3 } 
    end
    
    def five_in_a_row?
        @multiples.keys.each_cons(5).any? { |a| a[4] - a[0] == 4 }
    end
    
    def three_keepers_one_gap?
        @multiples.keys.each_cons(3).any? { |a| a[2] - a[0] == 3 }
    end
    
    def three_keepers_two_gaps?
        @multiples.keys.each_cons(3).any? { |a| a[2] - a[0] == 4 }
    end
    
    def four_keepers_one_gap?
        @multiples.keys.each_cons(4).any? { |a| a[3] - a[0] == 4 }
    end
    
end

new_game = Game.new

loop do
    new_game.start_game
end