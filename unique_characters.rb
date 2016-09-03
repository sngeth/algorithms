def unique_characters(str)
  used_chars = Hash.new

  str.each_char do |c|
    if used_chars[c] == true
      return false
    end
    used_chars[c] = true
  end

  return true
end
