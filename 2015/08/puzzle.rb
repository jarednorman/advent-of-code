class PartOne
  def initialize
  end

  def solve
    input.sum do |str|
      str.length - eval(str).length
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
    input.sum do |str|
      str.to_json.length - str.length
    end
  end
end
