require "minitest/autorun"

class MaxSingleSellProfit
  def find(arr)
    current_buy = arr[0]
    global_sell = arr[1]
    global_profit = global_sell - current_buy

    current_profit = 0

    for i in 1.. arr.length-1
      current_profit = arr[i] - current_buy

      if current_profit > global_profit
        global_profit = current_profit
        global_sell = arr[i]
      end

      if current_buy > arr[i]
        current_buy = arr[i]
      end
    end

    [global_sell - global_profit, global_sell]
  end
end

describe MaxSingleSellProfit do
  describe "#find" do
    it "returns the max profit with a single buy/sell activity" do
      arr = [12, 5, 9, 19]

      MaxSingleSellProfit.new.find(arr).must_equal [5, 19]
    end
  end
end

