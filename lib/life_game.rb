# bundle exec ruby life_game.rb

Bundler.require

class LifeGame
  attr_reader :cell

  def initialize(height, width)
    @height = height
    @width = width
    
    @cell = Array.new(@height) do
      Array.new(@width)
    end

    @height.times.each do |h|
      @width.times.each do |w|
        @cell[h][w] = Random.rand(2) == 0
      end
    end
  end

  def next_generation
    new_cell = Array.new(@height) do
      Array.new(@width)
    end

    for y in 0..(@height - 1)
      for x in 0..(@width - 1)
        new_cell[y][x] = next_generation_cell(x, y)
      end  
    end

    @cell = new_cell
  end

  def dump_cell
    @cell.map {|row| row.map {|col| col ? "*" : " " }.join}.join("\n")
  end

private

  def next_generation_cell(x, y)    
    if alive?(x, y)
      if neibors(x, y) < 2 || neibors(x, y) >= 4
        return false
      else
        return true
      end
    else
      if neibors(x, y) == 3
        return true
      else
        return false
      end
    end
  end

  def alive?(x, y)
    return @cell[y][x]
  end

  def neibors(x, y)
    n = 0
    _x = 0
    _y = 0

    # left
    _x = x - 1
    _x = @width - 1 if _x < 0
    _y = y
    if alive?(_x, _y)
      n += 1
    end

    # right
    _x = x + 1
    _x = 0 if _x >= @width
    _y = y
    if alive?(_x, _y)
      n += 1
    end

    # up
    _x = x
    _y = y - 1
    _y = @height - 1 if _y < 0
    if alive?(_x, _y)
      n += 1
    end

    # down
    _x = x
    _y = y + 1
    _y = 0 if _y >= @height
    if alive?(_x, _y)
      n += 1
    end

    # upleft
    _x = x - 1
    _x = @width - 1 if _x < 0
    _y = y - 1
    _y = @height - 1 if _y < 0
    if alive?(_x, _y)
      n += 1
    end

    # upright
    _x = x + 1
    _x = 0 if _x >= @width
    _y = y - 1
    _y = @height - 1 if _y < 0
    if alive?(_x, _y)
      n += 1
    end

    # downright
    _x = x + 1
    _x = 0 if _x >= @width
    _y = y + 1
    _y = 0 if _y >= @height
    if alive?(_x, _y)
      n += 1
    end

    # downleft
    _x = x - 1 
    _x = @width - 1 if _x < 0
    _y = y + 1
    _y = 0 if _y >= @height
    if alive?(_x, _y)
      n += 1
    end

    n
  end
end

height, width = `stty size`.split.map(&:to_i)
game = LifeGame.new(height, width)

trap(:INT) do
  exit
end

while true
  print game.dump_cell
  print "\e[1;1H"
  game.next_generation
  sleep 0.1
end
