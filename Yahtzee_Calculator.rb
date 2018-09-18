=begin
Yahtzee Calculator

Program by Dylan McClain, June & July 2018
Current version August 2018

Upcoming Revisions:
* Use dataset from method parse_dice_and_check to print dice numbers
    when providing calculations to user (e.g. Your chance of rolling 
    a straight is x IF YOU KEEP YOUR 2,3,4, and 5)
* Create a consistent order of outputs that states what you have first,
    then what your chances of various outcomes are, not intermixed
* Eliminate the scenario variable and the printing of "scenario we
    investigated was"
*Round to nearest whole or half percent
* Check calculations against another person's yahtzee calcuator
*BONUS use the point values of outcomes like full house and large straight to
    make a strategic recommendation to the user.
*Happy Rolling
=end

require_relative 'Yahtzee_Probability_Calculations'

puts %q{Welcome to Yahtzee Calculator v. 2.1
        Enter your roll by just listing the numbers on the dice.
        Type 'exit' to exit.
        Happy rolling!}

class Game

    def initialize
        @dice = []
        @roll_count
        @multiples = {}
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

        until @roll_count.between?(1,2)
            puts "Well, that's not right.\nIt's either 1 or 2. Which is it?"
            @roll_count = gets.to_i
        end
    end
    
    #creates two arrays, one for the numbers you rolled
    #and one for the amount of times you rolled each number
    #and then maps those arrays into a hash
    #then (optional) iterates through the hash to tell player about @multiples
    def organize_dice
        unique_numbers = @dice.uniq.each
        occurrences = []
        @dice.uniq.each { |n| occurrences << @dice.count(n)}
        @multiples = unique_numbers.zip(occurrences).to_h
        #@multiples.each { |k,v| puts "You have #{v} of a kind with #{k}s" }
    end

    #parses the hash @multiples and then calls the methods that check for
    #all the possible scenarios
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
    
    #calculates full house probability within the method
    #scenarios are: three of a kind or two pair
    def check_full_house(singletons, pairs, triples)
        if triples.any? && pairs.empty?
            scenario = 'full house'
            chance = (((1.0/6.0) + (5.0/36.0)*(@roll_count-1))*100).truncate(2)
            puts "If you save your #{singletons.join(' or your ')} your chance of rolling a full house is #{chance}%"
        elsif pairs.length == 2
            scenario = 'full house'
            chance = (((1.0/3.0) + (10.0/36.0)*(@roll_count-1))*100).truncate(2)
            puts "If you save your two pairs your chance of rolling a full house is #{chance}%"
        elsif pairs.any? && triples.any?
            puts "You already have a full house!"
        end
    end

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

    #check for straight draws, call methods from YahtzeeCalculations.rb
    def check_straight
        if five_in_a_row?
            puts "You have a large straight!"
        elsif four_in_a_row?
            puts "You already have a small straight!"
            if (@multiples.keys & [1,6]).any?
                scenario = 'four keepers, one edge'
                straight_E(@roll_count)
            else
                scenario = 'four keepers, two edges'
                straight_F(@roll_count)
            end
        elsif three_in_a_row?
            if four_keepers_one_gap?
                scenario = 'four keepers, one gap'
                straight_E(@roll_count)
            elsif (@multiples.keys & [1,6]).any?
                scenario = 'three keepers, one edge'
                straight_A(@roll_count)
            else
                scenario = 'three keepers, two edges'
                straight_D(@roll_count)
            end
        elsif three_keepers_one_gap?
            if (@multiples.keys & [1,6]).any?
                scenario = 'three keepers, one gap, one edge'
                straight_A(@roll_count)
            else
                scenario = 'three keepers, one gap, two edges'
                straight_B(@roll_count)
            end
        elsif three_keepers_two_gaps?
            scenario = 'three keepers, two gaps'
            straight_C(@roll_count)
        else
            scenario = 'no straight draw'
        end

        puts "The program determined we should investigate #{scenario}"
    end

    #methods used in check_straight
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