class PartOne
  def initialize
    input[1] = 12
    input[2] = 2
  end

  def solve
    @position = 0

    loop do
      case current_instruction
      when 1
        input[op3] = input[op1] + input[op2]
      when 2
        input[op3] = input[op1] * input[op2]
      when 99
        return input[0]
      else
        raise "Bad instruction: #{current_instruction}"
      end

      @position += 4
    end
  end

  private

  def op1
    input[@position + 1]
  end

  def op2
    input[@position + 2]
  end

  def op3
    input[@position + 3]
  end

  def current_instruction
    input[@position]
  end

  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read(Pathname.new(path).join("input.txt")).chomp.split(',').map(&:chomp).map(&:to_i)
      end
  end
end

class PartTwo < PartOne
  def solve
    0
  end
end
