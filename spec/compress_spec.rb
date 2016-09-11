require './compressor'

describe Compressor do
  it "should compress a string" do
    compressed = Compressor.compress("aabcccccaaa")
    expect(compressed).to eq "a2b1c5a3"
  end
end
