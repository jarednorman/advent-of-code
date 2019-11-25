class PartOne
  def initialize
  end

  def solve
    input.count do |string|
      next false if %w(ab cd pq xy).any? { |w| string.include? w }
      next false if string.split('').chunk(&:itself).lazy.map(&:last).find { |l| l.length > 1 }.nil?
      next false unless string.scan(/[aeiou]/).length >= 3

      true
    end
  end

  private

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
    input.count do |string|
      string.match?(/(\w\w).*\1/) && string.match?(/(\w).\1/)
    end
  end
end
