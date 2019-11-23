class PartOne
  def initialize
  end

  def solve
    input.split.map(&:to_i).sum
  end

  private

  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read Pathname.new(path).join("input.txt")
      end
  end
end

class PartTwo < PartOne
  def solve
    seen = Hash.new { 0 }
    current = 0

    input.split.map(&:to_i).cycle do |n|
      seen[current] += 1

      if seen[current] == 2
        return current
      end

      current += n
    end
  end
end
