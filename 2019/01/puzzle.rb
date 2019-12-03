class PartOne
  def initialize
  end

  def solve
    input.sum do |n|
      fuel n
    end
  end

  private

  def fuel(mass)
    (mass / 3).floor - 2
  end

  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read(Pathname.new(path).join("input.txt")).chomp.lines.lazy.map(&:chomp).map(&:to_i)
      end
  end
end

class PartTwo < PartOne
  def solve
    0
  end
end
