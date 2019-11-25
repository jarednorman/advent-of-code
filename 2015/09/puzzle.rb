class PartOne
  def initialize
  end

  def solve
    input.each do |line|
      a, b, d = */(\w+) to (\w+) = (\d+)/.match(line).captures

      locations << a
      locations << b

      distances[Set.new([a, b])] = d.to_i
    end

    locations.to_a.permutation.map { |locs|
      locs.each_cons(2).sum { |x| distances[Set.new(x)] }
    }.min
  end

  private

  def distances
    @distances ||= {}
  end

  def locations
    @locations ||= Set.new
  end

  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read(Pathname.new(path).join("input.txt")).chomp.lines.lazy.map(&:chomp)
      end
  end
end

class PartTwo < PartOne
  def solve
    input.each do |line|
      a, b, d = */(\w+) to (\w+) = (\d+)/.match(line).captures

      locations << a
      locations << b

      distances[Set.new([a, b])] = d.to_i
    end

    locations.to_a.permutation.map { |locs|
      locs.each_cons(2).sum { |x| distances[Set.new(x)] }
    }.max
  end
end
