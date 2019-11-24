require 'digest'

class PartOne
  def initialize
  end

  def solve
    (1..).find { |n|
      hex = Digest::MD5.new.tap do |digest|
        digest << "#{input}#{n}"
      end.hexdigest

      hex[0..4] == "00000"
    }
  end

  private

  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read(Pathname.new(path).join("input.txt")).chomp
      end
  end
end

class PartTwo < PartOne
  def solve
    (1..).find { |n|
      hex = Digest::MD5.new.tap do |digest|
        digest << "#{input}#{n}"
      end.hexdigest

      hex[0..5] == "000000"
    }
  end
end
