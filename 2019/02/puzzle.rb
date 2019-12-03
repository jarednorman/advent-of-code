class PartOne
  def initialize
  end

  def solve
    run(12, 2)
  end

  private

  def run(noun, verb)
    reset_program!
    input[1] = noun
    input[2] = verb
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

  def reset_program!
    @input = nil
  end
end

class PartTwo < PartOne
  def solve
    (0..99).each do |noun|
      (0..99).each do |verb|
        if run(noun, verb) == 19690720
          return 100 * noun + verb
        end
      end
    end
  end
end
