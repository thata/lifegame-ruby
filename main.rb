# bundle exec ruby main.rb

require './lib/life_game'

height, width = `stty size`.split.map(&:to_i)
game = LifeGame.new(height, width)

trap(:INT) do
  exit
end

while true
  print "\e[1;1H"
  game.dump_cell
  game.next_generation
  sleep 0.1
end
