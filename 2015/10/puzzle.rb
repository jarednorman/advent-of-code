class PartOne
  def initialize
  end

  def solve
    x = input
    40.times { x = iterate(x) }
    x.length
  end

  private

  def iterate(x)
    x.chunk(&:itself).flat_map do |z|
      [z.last.length, z.first]
    end
  end

  def input
    "1321131112".split('').map(&:to_i)
  end
end

class PartTwo < PartOne
  def solve
    0
  end
end
