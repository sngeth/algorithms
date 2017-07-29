require "minitest/autorun"
require "byebug"

class MoveZeroesToLeft
  def call(arr)
    read_index = write_index = arr.length - 1

    while read_index >= 0
      if !arr[read_index].zero?
        arr[write_index] = arr[read_index]
        write_index -= 1
      end

      read_index -= 1
    end

    while write_index >= 0
      arr[write_index] = 0
      write_index -= 1
    end

    arr
  end
end

describe MoveZeroesToLeft do
  describe "#call" do
    it "moves all 0 elements to left maintaining order of other elements" do
      arr = [1, 10, 20, 0, 59, 63, 0, 88, 0]

      expected = [0, 0, 0, 1, 10, 20, 59, 63, 88]
      MoveZeroesToLeft.new.call(arr).must_equal expected
    end
  end
end
