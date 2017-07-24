require "minitest/autorun"

class MaxInWindow
  attr_accessor :arr, :window_size

  def initialize(arr, window_size)
    @arr = arr
    @window_size = window_size
  end

  def solve
    result = []

    return if window_size > arr.length

    window = []

    # find out max for first window
    for i in 0 .. window_size - 1
      # remove elements smaller than or equal to current element in window
      while (window.length > 0 && arr[i] >= arr[window[-1]])
        window.pop
      end

      # add current element to window
      window.push(i)
    end

    result.push(arr[window[0]])

    # process rest of array
    for i in window_size .. arr.length - 1
      # remove elements smaller than or equal to current element in window
      while (window.length > 0 && arr[i] >= arr[window[-1]])
        window.pop
      end

      # remove the element at head if its index no longer in current window
      while (window.length > 0 && (window[0] <= i - window_size))
        window.shift()
      end

      # add current element to window
      window.push(i)

      # head of list is current max
      result.push(arr[window[0]])
    end

    result
  end
end

describe "Maximum in Sliding Window" do
  it "finds current max in window as the window slides through the entire array" do
    arr = [-4, 2, -5, 1, -1, 6 ]
    window_size = 3

    MaxInWindow.new(arr, window_size).solve.must_equal [2, 2, 1, 6]
  end
end
