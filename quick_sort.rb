def quicksort(array, low, high)
  pivot = get_pivot(array, low, high)
  i = low
  j = high

  while (i <= j)
    while (array[i] < pivot)
      i = i + 1
    end

    while (array[j] > pivot)
      j = j - 1
    end

    if (i <= j)
      swap(array, i, j)
      i = i + 1
      j = j - 1
    end
  end

  if (low < j)
    quicksort(array, low, j)
  end

  if (high > i)
    quicksort(array, i, high)
  end
end

def get_pivot(array, low, high)
  middle = low + (high - low) / 2
  array[middle]
end

def swap(array, i, j)
  temp = array[i]
  array[i] = array[j]
  array[j] = temp
end

array = [4,3,5,2,1]
quicksort(array, 0, array.length - 1)
puts "array is #{array}"
