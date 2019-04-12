=begin
    Yahtzee Probability Calculations

    These calculations employ a transitional array.  The transitional array is an array of
    probablities of how many dice the player will have correct after one more roll.  The first
    element of the array will always be the probability of having the same number of dice 
    correct as before the roll, i.e. the probablity of the player's hand not improving.  The 
    final element of the array will always be the probability of having all necessary dice 
    correct. Intermediate elements will be the probability of making intermediate improvements
    in the player's hand.

    For example, the method triples_check() is called when a player has three of a kind. The 
    transitional array used by triples_check() contains three elements. The first element 
    describes the probability after one roll of remaining in a state with three dice correct.
    The second element describes the probability of improving to a state with four dice correct,
    and the final element describes the probability of improving to a state with five dice correct,
    a.k.a. YAHTZEE.
=end


def triples_check(roll_count)
    remain_triples = 25.0/36.0
    improve_to_quadruples = 10.0/36.0
    improve_to_yahtzee = 1.0/36.0
    if roll_count == 1
        quadruples_probabilty = (improve_to_quadruples * 100).truncate(2)
        yahtzee_probability = (improve_to_yahtzee * 100).truncate(2)
        return [quadruples_probabilty, yahtzee_probability]
    elsif roll_count == 2
        quadruples_on_second_roll = remain_triples * improve_to_quadruples
        quadruples_probabilty = ((improve_to_quadruples + quadruples_on_second_roll) * 100).truncate(2)
        yahtzee_on_second_roll = remain_triples * improve_to_yahtzee
        yahtzee_in_two_rolls = improve_to_quadruples * (6.0/36.0)
        yahtzee_probability = ((yahtzee_on_second_roll + yahtzee_in_two_rolls + improve_to_yahtzee) * 100).truncate(2)
        return [quadruples_probabilty, yahtzee_probability]
    end
end

def pairs_check(roll_count)
    remain_pair = 108.0/216.0
    improve_to_triples = 92.0/216.0
    improve_to_quadruples = 15.0/216.0
    improve_to_yahtzee = 1.0/216.0
    if roll_count == 1
        triples_probability = (improve_to_triples * 100).truncate(2)
        quadruples_probabilty = (improve_to_quadruples * 100).truncate(2)
        yahtzee_probability = (improve_to_yahtzee * 100).truncate(2)
        return [triples_probability, quadruples_probabilty, yahtzee_probability]
    elsif roll_count == 2
        triples_probability = ((improve_to_triples + (remain_pair * improve_to_triples)) * 100).truncate(2)
        quadruples_on_second_roll = (remain_pair * improve_to_quadruples)
        quadruples_in_two_rolls = (improve_to_triples * (10.0/36.0))
        quadruples_probabilty = ((improve_to_quadruples + quadruples_on_second_roll + quadruples_in_two_rolls) * 100).truncate(2)
        yahtzee_on_second_roll = remain_pair * improve_to_yahtzee
        triples_then_yahtzee = improve_to_triples*(1.0/36.0)
        quadruples_then_yahtzee = improve_to_quadruples * (1.0/6.0)
        yahtzee_probability = ((improve_to_yahtzee + yahtzee_on_second_roll + triples_then_yahtzee + quadruples_then_yahtzee) * 100).truncate(2)
        return [triples_probability, quadruples_probabilty, yahtzee_probability]
    end
end

#STRAIGHT DRAWS

#Scenarios(2): three keepers, one gap, one edge || three keepers, zero gaps, one edge
#Instances(4): (1,2,4) / (1,3,4) / (3,4,6) / (3,5,6) || (1,2,3) / (4,5,6)
def straight_A(roll_count)
    #Transitional Array (chance after one roll of having 3, 4, or 5 dice correct)
    transitional_array = [(20.0/36.0), (14.0/36.0), (2.0/36.0)]
    transitional_array_gap_dice = [(25.0/36.0), (9.0/36.0)]

    if roll_count == 1
        #Chance with one roll remaining is identical to the transitional array.
        #Small straight uses separate array because only the gap dice qualifies, not the edge.
        sm_straight = ((transitional_array_gap_dice[1])*100).truncate(2)
        lg_straight = ((transitional_array[2])*100).truncate(2)
        straights = [sm_straight, lg_straight]
    elsif roll_count == 2
        #SMALL STRAIGHT: add probablity of acheiving small straight on first roll (prob_a)
        #to probablity of acheiving it on the second roll.
        prob_a = transitional_array[0]*transitional_array_gap_dice[1]
        sm_straight = ((prob_a + transitional_array_gap_dice[1])*100).truncate(2)
        #LARGE STRAIGHT
        #prob_one is the chance of getting nothing on first roll and both dice on second roll
        prob_one = transitional_array[0]*transitional_array[2]
        #prob_two is the chance of getting edge dice on first roll and gap on second roll
        prob_two = (9.0/36.0)*(1.0/6.0)
        #prob_three is the chance of getting gap dice on first roll and either edge on second roll
        prob_three = transitional_array_gap_dice[1]*(2.0/6.0)
        #add these to chance of getting both dice on first roll
        lg_straight = ((transitional_array[2] + prob_one + prob_two + prob_three)*100).truncate(2)
        straights = [sm_straight, lg_straight]
    end
end

#Scenario: three unique dice, one gap, two edges
#Instances(2): (2,3,5) / (2,4,5)
def straight_B(roll_count)
    transitional_array = [(16.0/36.0), (16.0/36.0), (4.0/36.0)]
    transitional_array_gap_dice = [(25.0/36.0), (9.0/36.0)]

    if roll_count == 1
        #Chance with one roll remaining is identical to the transitional array.
        #Small straight uses separate array because only the gap dice qualifies, not the edge.
        sm_straight = ((transitional_array_gap_dice[1])*100).truncate(2)
        lg_straight = ((transitional_array[2])*100).truncate(2)
        straights = [sm_straight, lg_straight]
    elsif roll_count == 2
        #SMALL STRAIGHT
        prob_a = transitional_array[0]*transitional_array_gap_dice[1]
        sm_straight = ((prob_a + transitional_array_gap_dice[1])*100).truncate(2)
        #LARGE STRAIGHT
        #prob_one is chance of rolling nothing on first roll and both dice on second roll
        prob_one = transitional_array[0]*transitional_array[2]
        #prob_two is chance of gap dice on first roll and either edge on second roll
        prob_two = transitional_array_gap_dice[1]*(2.0/6.0)
        #prob_three is chance of either edge on first roll and gap on second roll
        prob_three = (20.0/36.0)*(1.0/36.0)
        #add these to the chance of getting both gap and edge on first roll
        lg_straight = ((prob_one + prob_two + prob_three + transitional_array[2])*100).truncate(2)
        straights = [sm_straight, lg_straight]
    end
end

#Scenario: three keepers, two gaps, zero edges
#Instances(6): (1,2,5) / (1,3,5) / (1,4,5) / (2,3,6) / (2,4,6) / (2,5,6)
def straight_C(roll_count)
    if roll_count == 1
        lg_straight = ((2.0/36.0)*100).truncate(2)
    elsif roll_count == 2
        lg_straight = (((12.0/36.0)*(1.0/6.0) + (2.0/36.0))*100).truncate(2)
    end
end


#Scenario: three keepers, zero gaps, two edges
#Instances(2): (2,3,4) / (3,4,5)
def straight_D(roll_count)
    if roll_count == 1
        sm_straight = ((20.0/36.0)*100).truncate(2)
        lg_straight = ((2.0/36.0)*100).truncate(2)
        straights = [sm_straight, lg_straight]
    elsif roll_count == 2
        sm_straight = (((16.0/36.0)*(20.0/36.0) + (20.0/36.0))*100).truncate(2)
        #LARGE STRAIGHT
        #prob_one is the chance of rolling short edge (1 or 6) on first roll and long edge on second
        prob_one = (9.0/36.0)*(1.0/6.0)
        #prob_two is chance of rolling long edge on first roll and either remaining edge on second
        prob_two = (9.0/36.0)*(2.0/6.0)
        #prob_three is chance of rolling nothing on first roll and both on second
        prob_three = ((16.0/36.0)*(2.0/36.0))
        #add these to the chance of rolling both on first roll
        lg_straight = ((prob_one + prob_two + prob_three + (2.0/36.0))*100).truncate(2)
        straights = [sm_straight, lg_straight]
    end
end

#Scenarios(2): four keepers, one gap || four keepers, zero gaps, one edge, (small straight in hand)
#Instances(8): (1,2,3,5) / (1,2,4,5) / (1,3,4,5) / (2,3,4,6) / (2,3,5,6) / (2,4,5,6) || (1,2,3,4) / (3,4,5,6)
def straight_E(roll_count)
    if roll_count == 1
        lg_straight = ((1.0/6.0)*100).truncate(2)
    elsif
        roll_count == 2
        lg_straight = ((((5.0/6.0)*(1.0/6.0)) + (1.0/6.0))*100).truncate(2)
    end
end

#Scenario: four keepers, zero gaps, two edges, (small straight in hand)
#Instances(1): (2,3,4,5)
def straight_F(roll_count)
    if roll_count == 1
        lg_straight = ((2.0/6.0)*100).truncate(2)
    elsif
        roll_count == 2
        lg_straight = (((4.0/6.0)*(2.0/6.0) + (2.0/6.0))*100).truncate(2)
    end
end
