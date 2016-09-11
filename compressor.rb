require 'byebug'

class Compressor
  def self.compress(str)
    table = Hash.new
    compressed_string = ""

    str.chars.each_with_index do |char, i|
      table[char] ||= 1

      if(str.chars[i] != str.chars[i+1])
        compressed_string << char + table[char].to_s
        table[char] = 0
      end

      table[char] += 1
    end

    compressed_string
  end
end
