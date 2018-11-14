def triples_check(roll_count)
    #transitional array is chance after one roll of being in state with 3, 4, or 5 dice correct
    transitional_arr = [(25.0/36.0), (10.0/36.0), (1.0/36.0)]
    if roll_count == 1
        quads_chance = (transitional_arr[1]*100).truncate(2)
        yahtz_chance = (transitional_arr[2]*100).truncate(2)
        puts "Your chance of rolling four of a kind is #{quads_chance}%"
        puts "Your chance of rolling YAHTZEE is #{yahtz_chance}%"
    elsif roll_count == 2
        #calculate chance of getting quadruples on 2nd roll
        prob_a = transitional_arr[0]*transitional_arr[1]
        #add to chance of getting quadruples on first roll
        quads_chance = ((transitional_arr[1] + prob_a)*100).truncate(2)
        #for yahtzee, chance of getting nothing on roll one and both dice on roll two
        prob_one = transitional_arr[0]*transitional_arr[2]
        #chance of getting one dice on roll one and one on roll two
        prob_two = transitional_arr[1]*(6.0/36.0)
        #add these to chance of getting both dice first roll
        yahtz_chance = ((prob_one + prob_two + transitional_arr[2])*100).truncate(2)
        puts "Your chance of rolling four of a kind is #{quads_chance}%"
        puts "Your chance of rolling YAHTZEE is #{yahtz_chance}%"
    end
end

def pairs_check(roll_count)
    transitional_arr = [(108.0/216.0),(92.0/216.0),(15.0/216.0),(1.0/216.0)]
    if roll_count == 1
        trips_chance = (transitional_arr[1]*100).truncate(2)
        quads_chance = (transitional_arr[2]*100).truncate(2)
        yahtz_chance = (transitional_arr[3]*100).truncate(2)
        puts "Your chance of rolling three of a kind is #{trips_chance}%"
        puts "Your chance of rolling four of a kind is #{quads_chance}%"
        puts "Your chance of rolling YAHTZEE is #{yahtz_chance}%"
    elsif roll_count == 2
        #add chance of triples on first roll to chance of nothing on first roll and triples on second roll
        trips_chance = ((transitional_arr[1] + (transitional_arr[0]*transitional_arr[1]))*100).truncate(2)
        #for quadruples, chance of getting nothing on first roll and quadruples on second roll
        prob_a = (transitional_arr[0]*transitional_arr[2])
        #chance of getting triples on first roll and quadruples on second roll
        prob_b = (transitional_arr[1]*(10.0/36.0))
        #add these to chance of getting quadruples on first roll
        quads_chance = ((transitional_arr[2] + prob_a + prob_b)*100).truncate(2)
        #for yahtzee, chance of getting nothing on first roll and yahtzee on second roll
        prob_one = transitional_arr[0]*transitional_arr[3]
        #chance of getting triples on first roll and yahtzee on second roll
        prob_two = transitional_arr[1]*(1.0/36.0)
        #chance of getting quadruples on first roll and yahtzee on second roll
        prob_three = transitional_arr[2]*(1.0/6.0)
        #add these to chance of getting yahtzee on first roll
        yahtz_chance = ((transitional_arr[3] + prob_one + prob_two + prob_three)*100).truncate(2)
        puts "Your chance of rolling three of a kind is #{trips_chance}%"
        puts "Your chance of rolling four of a kind is #{quads_chance}%"
        puts "Your chance of rolling YAHTZEE is #{yahtz_chance}%"
    end
end

#STRAIGHT DRAWS
#Scenarios(2): three unique dice, one gap, one edge // three unique dice, zero gaps, one edge (stacked)
#Instances(4): (1,2,4) // (1,3,4) // (3,4,6) // (3,5,6) //// (1,2,3) // (4,5,6)
def straight_A(roll_count)
    #Transitional Array (chance after one roll of having 3, 4, or 5 dice correct)
    transitional_arr = [(20.0/36.0), (14.0/36.0), (2.0/36.0)]
    transitional_arr_gap_dice = [(25.0/36.0), (9.0/36.0)]

    if roll_count == 1
        #chance with one roll remaining is same as the transitional array
        #small straight uses separate array because only the gap dice qualifies, not the edge
        sm_straight = ((transitional_arr_gap_dice[1])*100).truncate(2)
        lg_straight = ((transitional_arr[2])*100).truncate(2)
        puts "Your chance of rolling a small straight is #{sm_straight}%"
        puts "Your chance of rolling a large straight is #{lg_straight}%"
    elsif roll_count == 2
        #calculate chance of small straight by adding prob of 
        #getting it on the second roll to prob of getting it on first roll
        prob_a = transitional_arr[0]*transitional_arr_gap_dice[1]
        sm_straight = ((prob_a + transitional_arr_gap_dice[1])*100).truncate(2)
        #for large straight, chance of getting nothing on first roll and both dice on second roll
        prob_one = transitional_arr[0]*transitional_arr[2]
        #chance of getting edge dice on first roll and gap on second roll
        prob_two = (9.0/36.0)*(1.0/6.0)
        #chance of getting gap dice on first roll and one of two edges on second roll
        prob_three = transitional_arr_gap_dice[1]*(2.0/6.0)
        #add these to chance of getting both dice on first roll
        lg_straight = ((transitional_arr[2] + prob_one + prob_two + prob_three)*100).truncate(2)
        puts "Your chance of rolling a small straight is #{sm_straight}%"
        puts "Your chance of rolling a large straight is #{lg_straight}%"
    end
end

#scenario: three unique dice, one gap, two edges
#Instances(2): (2,3,5) // (2,4,5)
def straight_B(roll_count)
    transitional_arr = [(16.0/36.0), (16.0/36.0), (4.0/36.0)]
    transitional_arr_gap_dice = [(25.0/36.0), (9.0/36.0)]

    if roll_count == 1
        sm_straight = ((transitional_arr_gap_dice[1])*100).truncate(2)
        lg_straight = ((transitional_arr[2])*100).truncate(2)
        puts "Your chance of rolling a small straight is #{sm_straight}%"
        puts "Your chance of rolling a large straight is #{lg_straight}%"
    elsif roll_count == 2
        prob_a = transitional_arr[0]*transitional_arr_gap_dice[1]
        sm_straight = ((prob_a + transitional_arr_gap_dice[1])*100).truncate(2)
        #chance of nothing on first roll and both dice on second roll
        prob_one = transitional_arr[0]*transitional_arr[2]
        #chance of gap dice on first roll and one of two edges on second roll
        prob_two = transitional_arr_gap_dice[1]*(2.0/6.0)
        #chance of one of two edges on first roll and gap on second roll
        prob_three = (20.0/36.0)*(1.0/36.0)
        #add it to chance of both on first roll
        lg_straight = ((prob_one + prob_two + prob_three + transitional_arr[2])*100).truncate(2)
    end
end

#scenario: three unique dice, two gaps, zero edges
#Instances(6): (1,2,5) // (1,3,5) // (1,4,5) // (2,3,6) // (2,4,6) // (2,5,6)
def straight_C(roll_count)
    if roll_count == 1
        lg_straight = ((2.0/36.0)*100).truncate(2)
        puts "Your chance of rolling a large straight is #{lg_straight}%"
    elsif roll_count == 2
        lg_straight = (((12.0/36.0)*(1.0/6.0) + (2.0/36.0))*100).truncate(2)
        puts "Your chance of rolling a large straight is #{lg_straight}%"
    end
end


#scenario: three unique dice, zero gaps, two edges
#Instances(2): (2,3,4) // (3,4,5)
def straight_D(roll_count)
    if roll_count == 1
        sm_straight = ((20.0/36.0)*100).truncate(2)
        lg_straight = ((2.0/36.0)*100).truncate(2)
        puts "Your chance of rolling a small straight is #{sm_straight}%"
        puts "Your chance of rolling a large straight is #{lg_straight}%"
    elsif roll_count == 2
        sm_straight = (((16.0/36.0)*(20.0/36.0) + (20.0/36.0))*100).truncate(2)
        #chance of rolling short edge on first roll and long edge on second
        prob_one = (9.0/36.0)*(1.0/6.0)
        #chance of rolling long edge on first roll and one of two remaining edges on second
        prob_two = (9.0/36.0)*(2.0/6.0)
        #chance of rolling nothing on first roll and both on second
        prob_three = ((16.0/36.0)*(2.0/36.0))
        #add to chance of rolling both on first roll
        lg_straight = ((prob_one + prob_two + prob_three + (2.0/36.0))*100).truncate(2)
        puts "Your chance of rolling a small straight is #{sm_straight}%"
        puts "Your chance of rolling a large straight is #{lg_straight}%"
    end
end

#scenarios(2): four unique dice, one gap // four unique dice, zero gaps, one edge, (small straight in hand)
#Instances(8): (1,2,3,5) // (1,2,4,5) // (1,3,4,5) // (2,3,4,6) // (2,3,5,6) // (2,4,5,6) //// (1,2,3,4) // (3,4,5,6)
def straight_E(roll_count)
    if roll_count == 1
        lg_straight = ((1.0/6.0)*100).truncate(2)
    elsif
        roll_count == 2
        lg_straight = ((((5.0/6.0)*(1.0/6.0)) + (1.0/6.0))*100).truncate(2)
    end
end

#scenario: four unique dice, zero gaps, two edges, (small straight in hand)
#Instances(1): (2,3,4,5)
def straight_F(roll_count)
    if roll_count == 1
        lg_straight = ((2.0/6.0)*100).truncate(2)
        puts "Your chance of rolling a large straight is #{lg_straight}%"
    elsif
        roll_count == 2
        lg_straight = (((4.0/6.0)*(2.0/6.0) + (2.0/6.0))*100).truncate(2)
        puts "Your chance of rolling a large straight is #{lg_straight}%"
    end
end

#case of: two consecutive numbers, central
#Instances(1): (3,4)

#case of: two consecutive numbers, open-ended
#Instances(2): (2,3) // (4,5)

#case of: two consecutive numbers, close-ended
#Instances(2): (1,2) // (5,6)

#cases of two non-consecutive numbers