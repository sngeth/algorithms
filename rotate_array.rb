require "minitest/autorun"
require "byebug"

class RotatedArray
  def rotate(arr, n)
    len = arr.length

    if (n < 0)
      # calculate the positive rotations needed.
      n = n + len
    end

    temp = Array.new(n-1)

    # copy last N elements of array into temp
    arr.each_with_index do |num, i|
      temp[i] = arr[len - n + i]
    end

    # shift original array
    (len - 1).downto(n) { |num| arr[num] = arr[num - n] }

    # copy temp into original array
    for i in 0 .. n-1
      arr[i] = temp[i]
    end

    arr
  end
end

describe RotatedArray do
  describe "#rotate" do
    it "rotates array by N elements" do
      arr = [1, 10, 20, 0, 59, 86, 32, 11, 9, 40]
      n = 2

      expected = [9, 40, 1, 10, 20, 0, 59, 86, 32, 11]

      RotatedArray.new.rotate(arr, n).must_equal expected
    end

    it "rotates array by negative N elements" do
      arr = [1, 10, 20, 0, 59, 86, 32, 11, 9, 40]
      n = -3

      expected = [0, 59, 86, 32, 11, 9, 40, 1, 10, 20]

      RotatedArray.new.rotate(arr, n).must_equal expected
    end
  end
end
