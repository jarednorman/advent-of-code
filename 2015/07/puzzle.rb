class PartOne
  def initialize
  end

  def solve
    calculate("a")
    # binding.pry unless calculate("d") == 72
    # binding.pry unless calculate("e") == 507
    # binding.pry unless calculate("f") == 492
    # binding.pry unless calculate("g") == 114
    # binding.pry unless calculate("h") == 65412
    # binding.pry unless calculate("i") == 65079
    # binding.pry unless calculate("x") == 123
    # binding.pry unless calculate("y") == 456
  end

  private

  def calculate(wire)
    x = wires[wire]

    return x if x.is_a? Integer

    wires[wire] =
      if m = /(\w+) AND (\w+)/.match(x)
        value(m[1]) & value(m[2])
      elsif m = /(\w+) OR (\w+)/.match(x)
        value(m[1]) | value(m[2])
      elsif m = /(\w+) RSHIFT (\w+)/.match(x)
        value(m[1]) >> value(m[2])
      elsif m = /(\w+) LSHIFT (\w+)/.match(x)
        value(m[1]) << value(m[2])
      elsif m = /NOT (\w+)/.match(x)
        [~value(m[1])].pack('S').unpack('S').first
      elsif m = /(\w+)/.match(x)
        value(m[1])
      else
        binding.pry
      end
  end

  def value(z)
    if z.to_i.to_s == z
      z.to_i 
    else
      calculate(z)
    end.clamp(0, 65535)
  end

  def wires
    @wires ||= {}.tap do |h|
      input.each do |wire|
        source, destination = */(.*) -> (.*)/.match(wire).captures
        h[destination] = source
      end
    end
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
  def wires
    super.tap do |h|
      h["b"] = 956
    end
  end
end
