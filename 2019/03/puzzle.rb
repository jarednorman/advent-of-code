class PartOne
  def initialize
  end

  def solve
    intersections.map{|coords| coords.map(&:abs).sum }.min
  end

  private

  def intersections
    wire_a_instructions = input[0]
    wire_b_instructions = input[1]

    wire_a_coords = coords(input[0])
    wire_b_coords = coords(input[1])

    (wire_a_coords & wire_b_coords)
  end

  def coords(instructions)
    x = 0
    y = 0

    instructions.each_with_object(Set.new) do |ins, coords|
      dist = ins.slice(1..-1).to_i
      direction = ins[0]

      case direction
      when "U"
        dist.times do
          y += 1
          coords << [x, y]
        end
      when "D"
        dist.times do
          y -= 1
          coords << [x, y]
        end
      when "L"
        dist.times do
          x -= 1
          coords << [x, y]
        end
      when "R"
        dist.times do
          x += 1
          coords << [x, y]
        end
      else
        raise "Something bad happened."
      end
    end
  end

  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read(Pathname.new(path).join("input.txt")).chomp.lines.map(&:chomp).map{ |line| line.split(",") }
      end
  end
end

class PartTwo < PartOne
  def solve
    @hash = intersections.map { |x| [x, {}] }.to_h

    record_distance(:a, input[0])
    record_distance(:b, input[1])

    @hash.values.map {|x| x.values.sum }.min
  end

  private

  def record_distance(wire, instructions)
    x = 0
    y = 0
    distance = 0

    instructions.each do |ins|
      dist = ins.slice(1..-1).to_i
      direction = ins[0]

      case direction
      when "U"
        dist.times do
          y += 1
          distance += 1

          if @hash.keys.include?([x, y])
            @hash[[x, y]][wire] ||= distance
          end
        end
      when "D"
        dist.times do
          y -= 1
          distance += 1

          if @hash.keys.include?([x, y])
            @hash[[x, y]][wire] ||= distance
          end
        end
      when "L"
        dist.times do
          x -= 1
          distance += 1

          if @hash.keys.include?([x, y])
            @hash[[x, y]][wire] ||= distance
          end
        end
      when "R"
        dist.times do
          x += 1
          distance += 1

          if @hash.keys.include?([x, y])
            @hash[[x, y]][wire] ||= distance
          end
        end
      else
        raise "Something bad happened."
      end
    end
  end
end
