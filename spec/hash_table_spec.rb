require './hash_table'

RSpec.describe HashTable do
  let!(:hash) { HashTable.new }

  describe "#insert" do
    it "puts data item into the table" do
      expect(hash.insert("a key", "a value")).to eq([["a key", "a value"]])
    end
  end

  describe "#search" do
    it "should return the right value given a key" do
      hash.insert "a new key", "a new value"
      expect(hash.search("a new key")).to eq "a new value"
    end
  end
end
