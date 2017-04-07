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
