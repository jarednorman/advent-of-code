MAPPING = {
  "^" => [ 0,  1],
  "v" => [ 0, -1],
  "<" => [-1,  0],
  ">" => [ 1,  0],
}

class PartOne
  def initialize
  end

  def solve
    visits = Hash.new(0)

    x, y = 0, 0
    visits[[x, y]] += 1
    input.each do |instruction|
      vx, vy = *MAPPING[instruction]
      x += vx
      y += vy
      visits[[x, y]] += 1
    end

    visits.count
  end

  private

  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read(Pathname.new(path).join("input.txt")).chomp.split('')
      end
  end
end

class PartTwo < PartOne
  def solve
    visits = Hash.new(0)

    x, y = 0, 0
    rx, ry = 0, 0

    visits[[x, y]] += 1
    visits[[rx, ry]] += 1

    input.each_slice(2) do |instructions|
      vx, vy = *MAPPING[instructions.first]
      x += vx
      y += vy

      visits[[x, y]] += 1

      vx, vy = *MAPPING[instructions.last]
      rx += vx
      ry += vy

      visits[[rx, ry]] += 1
    end

    visits.count
  end
end
