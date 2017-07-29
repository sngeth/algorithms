require "minitest/autorun"
require "set"

class HasPairOfSum
  def self.check?(arr, val)
    found_values = Set.new

    arr.each do |num|
      if found_values.include?(val - num)
        return true
      end

      found_values.add(num)
    end

    false
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
