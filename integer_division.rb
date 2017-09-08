require "minitest/autorun"

class IntegerDivision
  def self.divide(x, y)
    if y == 0
      return -1
    end

    if x < y
      return 0
    elsif x == y
      return 1
    elsif y == 1
      return x
    end

    q = 1
    val = y

    while val < x
      val = val << 2
      q = q << 2
    end

    if val > x
      val = val >> 2
      q = q >> 2
      return q + divide(x - val, y)
    end

    return q
  end
end

describe IntegerDivision do
  describe "#call" do
    it "divides without using / or *" do
      IntegerDivision.divide(7, 2).must_equal 3
      IntegerDivision.divide(5, 4).must_equal 1
      IntegerDivision.divide(1, 3).must_equal 0
    end
  end
end
