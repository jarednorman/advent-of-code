class Command
  def initialize(string)
    @command, @from_x, @from_y, @to_x, @to_y = */(turn off|turn on|toggle) (\d+),(\d+) through (\d+),(\d+)/.match(string).captures
    @from_x = @from_x.to_i
    @from_y = @from_y.to_i
    @to_x = @to_x.to_i
    @to_y = @to_y.to_i
  end

  def apply(board)
    (@from_x..@to_x).each do |x|
      (@from_y..@to_y).each do |y|
        case @command
        when "turn off"
          board[x][y] = :off
        when "turn on"
          board[x][y] = :on
        when "toggle"
          board[x][y] = board[x][y] == :off ? :on : :off
        else
          raise "OH NO NOT A COMMAND: #{@command}"
        end
      end
    end
  end

  def apply2(board)
    (@from_x..@to_x).each do |x|
      (@from_y..@to_y).each do |y|
        case @command
        when "turn off"
          board[x][y] -= 1 unless board[x][y] == 0
        when "turn on"
          board[x][y] += 1
        when "toggle"
          board[x][y] += 2
        else
          raise "OH NO NOT A COMMAND: #{@command}"
        end
      end
    end
  end
end

class PartOne
  def initialize
  end

  def solve
    input.map { |str| Command.new(str) }.each { |command| command.apply(board) }

    board.map { |col| col.count(:on) }.sum
  end

  private

  def board
    @board ||= 1000.times.map {
      1000.times.map { :off }
    }
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
  def solve
    input.map { |str| Command.new(str) }.each { |command| command.apply2(board) }

    board.map { |col| col.sum }.sum
  end

  private

  def board
    @board ||= 1000.times.map {
      1000.times.map { 0 }
    }
  end
end
