def permutation?(str1, str2)
  str1 = sort_chars_downcased(str1)
  str2 = sort_chars_downcased(str2)
  str1 == str2 ? true : false
end

def sort_chars_downcased(str)
  str.chars.sort_by(&:downcase).join
end

puts permutation? "abc","cba" # true
puts permutation? "abc","cbd" # false
