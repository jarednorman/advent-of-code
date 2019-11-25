class PartOne
  def initialize
  end

  def solve
    commands.each do |command|
      binding.pry unless command[:orig] == reconstruct(command)

      case command[:operator]
      when :AND, :OR, :RSHIFT, :LSHIFT
        board[command[:destination]] = {ins: [command[:operator], command[:operand1], command[:operand2]]}
      when :NOT
        board[command[:destination]] = {ins: [:NOT, command[:operand1]]}
      when :CONSTANT
        board[command[:destination]] = {ins: [:CONSTANT, command[:operand1]]}
      else
        raise "SMOOTH OPERATOR: #{command[:operator].inspect}"
      end
    end

    result = evaluate(:a)
    # binding.pry
    result
  end

  private

  def evaluate(wire_name)
    wire = board[wire_name]
    ins = wire[:ins]

    wire[:value] ||=
      case ins.first
      when :AND
        value(ins[1]) & value(ins[2])
      when :OR
        value(ins[1]) | value(ins[2])
      when :RSHIFT
        value(ins[1]) >> value(ins[2])
      when :LSHIFT
        value(ins[1]) << value(ins[2])
      when :NOT
        ~value(ins[1])
      when :CONSTANT
        value(ins[1])
      else
        raise "UNEXPECTED OPERATOR: #{ins.first.inspect}"
      end.clamp(0, 65535)

    wire[:value]
  end

  # Given either a literal value or wire name, evaluate it.
  def value(x)
    return x.clamp(0, 65535) if x.is_a? Integer
    evaluate(x).clamp(0, 65535)
  end

  def board
    @wires ||= Hash.new
  end

  def reconstruct command
    case command[:operator]
    when :AND, :OR, :RSHIFT, :LSHIFT
      "#{command[:operand1]} #{command[:operator]} #{command[:operand2]} -> #{command[:destination]}"
    when :NOT
      "NOT #{command[:operand1]} -> #{command[:destination]}"
    when :CONSTANT
      "#{command[:operand1]} -> #{command[:destination]}"
    else
      raise "SMOOTH OPERATOR: #{command[:operator].inspect}"
    end
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
           orig: c,
           operator: operator.to_sym,
           operand1: norm(a),
           operand2: norm(b),
           destination: dest.to_sym
         }
       elsif m = /NOT (\w+) -> (\w+)/.match(c)
         a, dest = *m.captures
         {
           orig: c,
           operator: :NOT,
           operand1: norm(a),
           destination: dest.to_sym
         }
       elsif m = /(\w+) -> (\w+)/.match(c)
         a, dest = *m.captures
         {
           orig: c,
           operator: :CONSTANT,
           operand1: norm(a),
           destination: dest.to_sym
         }
       else
         raise "BAD COMMAND: #{c.inspect}"
       end
    }
  end

  def norm a
    if a.to_i.to_s == a
      a.to_i
    else
      a.to_sym
    end
  end
end

class PartTwo < PartOne
  def solve
    0
  end
end
