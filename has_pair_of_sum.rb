require 'minitest/autorun'

class HasPairOfSum
  def self.check?(data, sum)
    hasPairOfSum = false
    compliments = {}

    data.each do |num|
      if compliments[num]
        hasPairOfSum = true
        break
      else
        compliments[num] = sum - num
      end
    end

    hasPairOfSum
  end
end

describe HasPairOfSum do
  before do
    @false_data = [1, 2, 4, 9]
    @true_data = [1, 2, 4, 4]
  end

  it "does't find pair of integers equal to sum of 8 in array" do
    HasPairOfSum.check?(@false_data, 8).must_equal false
  end

  it "finds pair of integers equal to sum of 8 in array" do
    HasPairOfSum.check?(@true_data, 8).must_equal true
  end
end
