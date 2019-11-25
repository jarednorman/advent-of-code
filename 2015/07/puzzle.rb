class PartOne
  def initialize
  end

  def solve
    commands.each do |command|
      case command[:operator]
      when :AND, :OR, :RSHIFT, :LSHIFT
        board[command[:destination]] = [command[:operator], command[:operand1], command[:operand2]]
      when :NOT
        board[command[:destination]] = [:NOT, command[:operand1]]
      when :CONSTANT
        board[command[:destination]] = [:CONSTANT, command[:operand1]]
      when :PASS
        board[command[:destination]] = [:PASS, command[:operand1]]
      else
        raise "SMOOTH OPERATOR: #{command[:operator].inspect}"
      end
    end
    binding.pry
  end

  private

  def board
    @wires ||= Hash.new
  end


  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read(Pathname.new(path).join("input.txt")).chomp.lines.lazy.map(&:chomp)
      end
  end

  def commands
    input.map { |c|
       if m = /(\w+) (AND|OR|RSHIFT|LSHIFT) (\w+) -> (\w+)/.match(c)
         a, operator, b, dest = *m.captures
         {
           operator: operator.to_sym,
           operand1: a.to_sym,
           operand2: b,
           destination: dest.to_sym
         }
       elsif m = /NOT (\w+) -> (\w+)/.match(c)
         a, dest = *m.captures
         {
           operator: :NOT,
           operand1: a.to_sym,
           destination: dest.to_sym
         }
       elsif m = /(\d+) -> (\w+)/.match(c)
         value, dest = *m.captures
         {
           operator: :CONSTANT,
           operand1: value.to_sym,
           destination: dest.to_sym
         }
       elsif m = /(\w+) -> (\w+)/.match(c)
         source, dest = *m.captures
         {
           operator: :PASS,
           operand1: source.to_sym,
           destination: dest.to_sym
         }
       else
         raise "BAD COMMAND: #{c.inspect}"
       end
    }
  end
end

class PartTwo < PartOne
  def solve
    0
  end
end
