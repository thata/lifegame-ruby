# bundle exec ruby main.rb

require './lib/life_game'

height, width = `stty size`.split.map(&:to_i)
game = LifeGame.new(height, width)

trap(:INT) do
  exit
end

1000.times do
  print "\e[1;1H"
  print game.dump_cell
  game.next_generation
end
