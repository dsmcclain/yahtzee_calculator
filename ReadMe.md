Welcome to Yahtzee Calculator!

Yahtzee Calculator is a program written by Dylan McClain that calculates
the probabilities of desired outcomes in the game of Yahtzee.

For those unfamiliar, Yahtzee is a dice game originally made by 
the Milton Bradley company.  It consists of five dice and a scoresheet,
and players take turns rolling the dice, keeping whichever
dice they want and rerolling the rest, until the player has completed
three rolls or chooses to stop.  The goal is to collect an array
of different outcomes, such as 'four of a kind', 'large straight', or
'Yahtzee', which is defined as all five dice of the same number.

A breakdown of the rules can be found [here](https://www.wikihow.com/Play-Yahtzee).

The Yahtzee Calculator consists of four files: this readme, a file containing
the app itself (yahtzee.rb), a file containing some basic Rspec tests (yahtzee_spec.rb), and a dependency containing all of the probability
calculations (yahtzee-calculations.rb).

The app is written in ruby 2.5.1  If you have ruby installed locally, you
can run the yahtzee calculator locally by forking and cloning the repository,
navigating to the directory containing the files and running
```
ruby yahtzee.rb
```
Happy rolling!