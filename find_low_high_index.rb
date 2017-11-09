require "minitest/autorun"

class FindHighLowIndex
  def low_index(arr, key)
    low = 0
    high = arr.length - 1
    mid = low + ((high - low ) / 2).floor

    while low <= high
      mid_elem = arr[mid]

      if mid_elem < key
        low = mid + 1
      else
        high = mid - 1
      end

      mid = low + ((high -low) / 2).floor

      if (arr[low] == key)
        return low
      end
    end

    return -1
  end

  def high_index(arr, key)
    low = 0
    high = arr.length - 1
    mid = low + ((high - low ) / 2).floor

    while low <= high
      mid_elem = arr[mid]

      if mid_elem <= key
        low = mid + 1
      else
        high = mid - 1
      end

      mid = low + ((high -low) / 2).floor

      if (arr[high] == key)
        return high
      end
    end

    return -1
  end
end

describe FindHighLowIndex do
  describe "#low_index" do
    it "finds lowest index of key in array" do
      arr = [1, 2, 5, 5, 5, 5, 5, 5, 5, 5, 20]
      key = 5

      FindHighLowIndex.new.low_index(arr, 5).must_equal 2
    end
  end

  describe "#high_index" do
    it "finds highest index of key in array" do
      arr = [1, 2, 5, 5, 5, 5, 5, 5, 5, 5, 20]
      key = 5

      FindHighLowIndex.new.high_index(arr, 5).must_equal 9
    end
  end
end

