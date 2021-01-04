# bundle exec ruby main.rb

require './lib/life_game'

def start_game
  height, width = `stty size`.split.map(&:to_i)
  game = LifeGame.new(height, width)

  # 1000世代実行して終了する
  1000.times do
    print "\e[1;1H"
    game.dump_cell
    game.next_generation
  end
end

# ブロック内の処理を計測
StackProf.run(out: '/tmp/stackprof.dump') do
  start_game
end
