require "minitest/autorun"

class SmallestCommonNumber
  def self.find(a1, a2, a3)
    #use three index pointers to traverse
    i = j = k = 0

    # loop through all three arrays until end
    while (i < a1.length && j < a2.length && k < a3.length)
      # return result if value of of array indices pointed to all 3 are equal
      if a1[i] == a2[j] && a2[j] == a3[k]
        return a1[i]
      end

      # advance pointer thats pointing to the smallest number among the three
      # since it's smaller than the rest we want to see if the next one matches
      # the the current smallest of the others.
      if (a1[i] <= a2[j] && a1[i] <= a3[k])
        i += 1
      elsif (a2[j] <= a1[i] && a2[j] <= a3[k])
        j += 1
      elsif (a3[k] <= a1[i] && a3[k] <= a2[j])
        k += 1
      end
    end

    return -1
  end
end

describe SmallestCommonNumber do
  describe "#find" do
    it "returns smallest number that is common in all three arrays" do
      a = [6, 7, 10, 25, 30, 64, 64]
      b = [-1, 4, 5, 6, 7, 8, 50]
      c = [1, 6, 10 , 14]

      SmallestCommonNumber.find(a, b, c).must_equal 6
    end

    it "returns -1 if there isn't a smallest common number" do
      a = [6, 7, 10, 25, 30, 64, 64]
      b = [-1, 4, 5, 6, 7, 8, 50]
      c = [1, 10 , 14]

      SmallestCommonNumber.find(a, b, c).must_equal -1
    end
  end
end
