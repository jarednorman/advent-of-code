class PartOne
  def initialize
  end

  def solve
    input.count("(") - input.count(")")
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
  DIRECTION = {
    "(" => 1,
    ")" => -1,
  }.freeze

  def solve
    current_floor = 0

    input.chomp.split("").each_with_index do |instruction, index|
      current_floor += DIRECTION[instruction]

      if current_floor == -1
        return index + 1
      end
    end
  end
end
