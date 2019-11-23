class PartOne
  def initialize
  end

  def solve
    x = input.split.map do |str|
      str.split('').inject(Hash.new(0)) do |acc,c| acc[c] += 1;acc end.values.uniq
    end

    x.count {|x| x.include? 2 } * x.count {|x| x.include? 3 }
  end

  private

  def input
    @input ||=
      begin
        path = File.expand_path(File.dirname(__FILE__))
        File.read Pathname.new(path).join("input.txt")
      end
  end
end

class PartTwo < PartOne
  def solve
    input.split.each do |str1|
      input.split.each do |str2|
        next if str1 == str2

        z = str1.split('').zip(str2.split('')).count do |a|
          a[0] != a[1]
        end

        if z == 1
          return str1.split('').zip(str2.split('')).select{|x|x[0]==x[1]}.map{|x|x[0]}.join
        end
      end
    end
  end
end
