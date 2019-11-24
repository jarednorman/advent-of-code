require 'pry'
require 'pry-stack_explorer'

module Advent
  class << self
    def run_puzzle
      puzzle_pathname = Pathname.new(puzzle_path)

      unless puzzle_pathname.exist?
        puzzle_pathname.mkpath

        input_path = Pathname.new(puzzle_path).join("input.txt")
        FileUtils.touch(input_path) unless input_path.exist?

        File.write(puzzle_file_path, <<~TEMPLATE)
          class PartOne
            def initialize
            end

            def solve
              0
            end

            private

            def input
              @input ||=
                begin
                  path = File.expand_path(File.dirname(__FILE__))
                  File.read(Pathname.new(path).join("input.txt"))
                end
            end
          end

          class PartTwo < PartOne
            def solve
              0
            end
          end
        TEMPLATE
      end

      require puzzle_file_path

      if part == 1
        puts "Solution: #{::PartOne.new.solve}"
      else
        puts "Solution: #{::PartTwo.new.solve}"
      end
    end

    private

    def root
      File.expand_path(File.dirname(__FILE__)).freeze
    end

    def year
      @year ||= ARGV[0].chomp.tap do |year|
        raise "The year looks off: #{year.inspect}" if year.to_i < 2015
      end
    end

    def puzzle
      @puzzle ||=
        begin
          puzzle = ARGV[1].chomp.to_i
          raise "The puzzle looks off: #{puzzle.inspect}" unless (1..25).include? puzzle
          '%.2i' % puzzle
        end
    end

    def part
      @part ||= ARGV[2].to_i.tap do |part|
        raise "The part looks off: #{part.inspect}" unless (1..2).include? part
      end
    end
 
    def puzzle_path
      [root, year, puzzle].join("/")
    end

    def puzzle_file_path
      puzzle_path + "/puzzle.rb"
    end
  end
end
