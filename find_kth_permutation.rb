def factorial(n)
  return 1 if (n == 0 || n == 1)
  return n * factorial(n-1)
end

def find_kth_permutation(v, k, result)
  return if !v || v.length == 0

  n = v.length
  # block_size
  count = factorial(n-1)

  # Find which block k will lie in and select the first element of that block
  selected = ((k - 1) / count).floor

  # Append selected element to result vector
  result[0] += '' + v[selected].to_s

  # Remove from original input list
  v = v - v.slice(selected, 1)

  # Deduce from k the blocks that are skipped
  k = k - (count * selected)

  find_kth_permutation(v, k, result)

  result
end

k = 8
input = [1, 2, 3, 4]
puts find_kth_permutation(input, k, [""]) # 2143
