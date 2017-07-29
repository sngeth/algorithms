require "minitest/autorun"

Pair = Struct.new(:fst, :snd)

class MergeOverlappingIntervals
  def find(arr)
    output = [arr.first]

    arr.each do |interval|
      x = interval.fst
      y = interval.snd
      last_y = output.last.snd

      # overlap check
      if x <= last_y
        output.last.snd = [y, last_y].max
      else
        output << Pair.new(x, y)
      end
    end

    output
  end
end

describe MergeOverlappingIntervals do
  describe "#find" do
    it "returns array over overlapping intervals" do
      arr = [Pair.new(1, 5), Pair.new(3, 7), Pair.new(4, 6), Pair.new(6, 8),
             Pair.new(10, 12), Pair.new(11, 15)]

      expected = [Pair.new(1, 8), Pair.new(10, 15)]

      MergeOverlappingIntervals.new.find(arr).must_equal expected
    end
  end
end
