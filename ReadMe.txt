Welcome to Yahtzee Calculator's ReadMe!

Yahtzee Calculator is a program written by Dylan McClain for calculating 
the probabilities of desired outcomes in the game of Yahtzee.

For those unfamiliar, Yahtzee is a dice game originally made by 
the Milton Bradley company.  It consists of five dice and a scoresheet,
and players take turns rolling the dice, keeping whichever
dice they want and rerolling the rest, until the player has completed
three rolls or chooses to stop.  The goal is to collect an array
of different outcomes, such as 'four of a kind', 'large straight', or
'Yahtzee', which is defined as all five dice of the same number.  (For
those who are curious, the probablity at the outset of each turn for
acheiving Yahtzee after three rolls is roughly 3.4%)

The program consists of two files: Yahtzee_Calculator.rb (which contains
the structure of the program), and Yahtzee_Probability_Calculations.rb
(which contains a majority of the mathematical calculations).

The following is a list of planned extensions and revisions to the program:
* Make output more user-friendly by printing instructions along with each
    caulculation (e.g. "your probability of rolling a large straight 
    is xyz% IF YOU KEEP YOUR 1, 2, AND 4")
* Output currently lists elements without an intentional order.  Make output
    more user-friendly by stating what the user already has first, and then 
    what the probabilities of various outcomes are.
* Eliminate the scenario variable and the printing of "scenario we
    investigated was."
* Make output more user friendly by rounding all probabilities to nearest 
    whole or half percent.