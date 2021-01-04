# bundle exec ruby main.rb

require './lib/life_game'

trap(:INT) do
  exit
end

# ブロック内の処理を計測
StackProf.run(out: '/tmp/stackprof.dump') do
  height, width = `stty size`.split.map(&:to_i)
  game = LifeGame.new(height, width)

  1000.times do
    print "\e[1;1H"
    game.dump_cell
    game.next_generation
  end
end
