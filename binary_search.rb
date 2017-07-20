require "minitest/autorun"

class BinarySearch
  def search(arr, key)
    # index of beginning of array
    low = 0
    # index of last item in array
    high = arr.length - 1

    # We divide the search in each iteration so that the problem space shrinks
    # and can no longer be divided. The indices of the array will eventually meet
    while low <= high

      # cannot do high-low / 2 due to integer overflow
      mid = low + ((high-low) / 2)

      # if we find the key at the point return that index and we're done
      if arr[mid] == key
        return mid
      end

      # Since we did'nt find it above we need to shrink the problem space some
      # more. If we know that our key is smaller than the item at the midpoint,
      # we can move the upper bound equal to 1 index left of the midpoint
      # because the the item can only be at an index lower than the current
      # midpoint. Otherwise we do the opposite and increase the lower bound
      if key < arr[mid]
        high = mid - 1
      else
        low = mid + 1
      end
    end

    return -1
  end
end


describe BinarySearch do
  it "finds index of key in a sorted array" do
    BinarySearch.new.search([1, 20, 47, 59, 63, 75, 88, 99], 47).must_equal 2
  end

  it "returns -1 if key not found" do
    BinarySearch.new.search([1, 20, 47, 59, 63, 75, 88, 99], 70).must_equal -1
  end
end
