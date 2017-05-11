# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi

  attr_reader :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def play
    puts "Welcome to Towers of Hanoi: The Game."
    until won?
      puts "Please enter the pile from which you would like to select a tower (0 to 2):"
      from_tower = gets.chomp.to_i
      from_tower = check_value(from_tower)

      puts "Now please enter the pile to which you would like to insert the selected tower (0 to 2):"
      to_tower = gets.chomp.to_i
      to_tower = check_value(to_tower)

      if valid_move?(from_tower, to_tower)
        move(from_tower, to_tower)
      else
        puts "That is not a valid move, please ensure the first pile is not empty"
        puts " and you are not moving a larger tower on top of a smaller tower."
      end
      puts render
    end
    puts render
    puts "Congratulations! You have won the game."
  end

  def render
    puts "First Pile"
    puts "[]" * towers[0][2].to_i
    puts "[]" * towers[0][1].to_i
    puts "[]" * towers[0][0].to_i
    puts ""

    puts "Second Pile"
    puts "[]" * towers[1][2].to_i
    puts "[]" * towers[1][1].to_i
    puts "[]" * towers[1][0].to_i
    puts ""

    puts "Third Pile"
    puts "[]" * towers[2][2].to_i
    puts "[]" * towers[2][1].to_i
    puts "[]" * towers[2][0].to_i
    puts ""
  end

  def won?
    towers[1].size == 3 || towers[2].size == 3
  end

  def valid_move?(from_tower, to_tower)
    if towers[from_tower].empty?
      false
    elsif !towers[to_tower].empty? && towers[from_tower].last > towers[to_tower].last
      false
    else true
    end
  end

  def move(from_tower, to_tower)
    towers[to_tower] << towers[from_tower].pop
  end

  def check_value(input)
    if input > 2 || input < 0
      puts "Out of range. Please enter a number ranging from 0 to 2."
      input = gets.chomp.to_i
    end
    input
  end

end

if __FILE__ == $PROGRAM_NAME
  new_game = TowersOfHanoi.new
  new_game.play
end
