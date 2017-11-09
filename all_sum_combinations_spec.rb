require "minitest/autorun"

class AllSumCombinations
  def self.print(target)
    output = []
    result = []
    print_all_sum_rec(target, 0, 1, output, result)

    result
  end

  def self.print_all_sum_rec(target, current_sum, start, output, result)
    if current_sum == target
      result.push output.dup
    end

    for i in start .. target-1
      temp_sum = current_sum + i
      if temp_sum <= target
        output.push(i)
        print_all_sum_rec(target, temp_sum, i, output, result)
        output.pop
      else
        return
      end
    end
  end
end

describe AllSumCombinations do
  it "prints all possible sum combos using positive integers" do
    result = AllSumCombinations.print(5)
    result.must_equal [[1, 1, 1, 1, 1], [1, 1, 1, 2], [1, 1, 3], [1, 2, 2], [1, 4], [2, 3]]
  end
end
