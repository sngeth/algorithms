require "minitest/autorun"

class Sort
  def quicksort(array)
    # base case arrays with 0 or 1 element are already "sorted"
    if array.length < 2
      array
    else
      pivot = array[0]
      # get sub-array of elements less than pivot
      less = array[1, array.size].keep_if { |e| e <= pivot }
      # get sub-array of elements greater than pivot
      greater = array[1, array.size].keep_if { |e| e > pivot }

      quicksort(less) + [pivot] + quicksort(greater)
    end
  end
end

describe Sort do
  describe "#quicksort" do
    it "returns a sorted array" do
      a = [55, 23, 26, 2, 18, 78, 23, 8, 2, 3]
      expected = [2, 2, 3, 8, 18, 23, 23, 26, 55, 78]

      Sort.new.quicksort(a).must_equal expected
    end
  end
end
