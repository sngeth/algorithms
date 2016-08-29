A = [4,3,5,2,1]

puts "Original array is #{A}"

(1..A.length-1).each_with_index do |i|
  while i > 0 && (A[i-1] > A[i]) do
    puts "swapping #{A[i]} and #{A[i-1]}"
    temp = A[i]
    A[i] = A[i-1]
    A[i-1] = temp
    i = i - 1
    puts "Array is now #{A}"
  end
end
