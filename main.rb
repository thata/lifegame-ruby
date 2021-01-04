# bundle exec ruby main.rb

require './lib/life_game'

# 計測開始
StackProf.stop

height, width = `stty size`.split.map(&:to_i)
game = LifeGame.new(height, width)

trap(:INT) do
  exit
end

while true
  print "\e[1;1H"
  print game.dump_cell
  game.next_generation
  sleep 0.1
end

# 計測終了
StackProf.stop
StackProf.results('/tmp/stackprof.dump')