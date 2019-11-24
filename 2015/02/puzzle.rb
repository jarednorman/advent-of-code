class Present
  def initialize(w:, h:, l:)
    @size = 2*l*w + 2*w*h + 2*h*l + [l*w, w*h, h*l].min

    x, y = *[l, w, h].min(2)
    @ribbon = 2*x + 2*y + l*w*h
  end

  def size
    @size
  end

  def ribbon
    @ribbon
  end
end

class PartOne
  def initialize
  end

  def solve
    input.sum do |spec|
      w, h, l = *spec.split("x")
      Present.new(w: w.to_i, h: h.to_i, l: l.to_i).size
    end
  end

  private

  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read(Pathname.new(path).join("input.txt")).chomp.split
      end
  end
end

class PartTwo < PartOne
  def solve
    input.sum do |spec|
      w, h, l = *spec.split("x")
      Present.new(w: w.to_i, h: h.to_i, l: l.to_i).ribbon
    end
  end
end
