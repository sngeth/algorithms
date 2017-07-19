require "minitest/autorun"
require "set"

class LongestSubstringNoRepeat
  def self.find(s)
    n = s.length
    set = Set.new

    ans = i = j = 0

    while i < n && j < n
      if !set.include?(s[j])
        set.add(s[j])
        j = j + 1
        ans = [ans, (j - i)].max
      else
        set.delete(s[i])
        i = i + 1
      end
    end

    ans
  end
end

describe LongestSubstringNoRepeat do
  it "finds length of longest substring without repeating characters" do
    LongestSubstringNoRepeat.find("abcabcbb").must_equal 3
    LongestSubstringNoRepeat.find("bbbbb").must_equal 1
    LongestSubstringNoRepeat.find("pwwkew").must_equal 3
  end
end
