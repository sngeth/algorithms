def reverse_chars(str)
  len = str.length - 1
  reversed_str = Array.new
  index = 0

  while len > -1
    reversed_str[index] = str[len]
    len -= 1
    index += 1
  end

  puts reversed_str.join
end
