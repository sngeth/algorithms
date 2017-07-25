require "minitest/autorun"
require "byebug"

describe "Search rotated array" do
  it "returns index of number" do
    data = [176, 188, 199, 200, 210, 222, 1, 10 , 20, 47, 59, 63, 75, 88, 99, 107, 120, 133, 155, 162]

    SearchRotatedArray.new.find(data, 200).must_equal 3
  end
end

class SearchRotatedArray
  def binary_search_modified_rec(arr, low, high, key)
    if (low > high)
      return -1
    end

    mid = low + ((high - low) / 2).floor

    return mid if (arr[mid] == key)


    if (arr[low] < arr[mid] && key < arr[mid] && key >= arr[low])
      return binary_search_modified_rec(arr, low, mid - 1, key)

    elsif (arr[mid] < arr[high] && key > arr[mid] && key <= arr[high])
      return binary_search_modified_rec(arr, mid + 1, high, key)

    elsif (arr[low] > arr[mid])
      return binary_search_modified_rec(arr, low, mid - 1, key)

    elsif (arr[high] < arr[mid])
      return binary_search_modified_rec(arr, mid + 1, high, key)
    end

    return -1
  end

  def find(arr, key)
    return binary_search_modified_rec(arr, 0, arr.length - 1, key)
  end
end
