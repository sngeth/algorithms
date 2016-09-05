require 'byebug'

class HashTable
  attr_accessor :buckets

  def initialize
    @buckets = []
  end

  def insert(key, value)
    index = get_hash_index(key)
    buckets[index] ||= []
    buckets[index] << [key, value]
  end

  def search(key)
    index = get_hash_index(key)
    buckets[index].each do |k, v|
      return v if k = key
    end
  end

  private
  def get_hash_index(key)
    key = key.to_sym
    key.object_id % 100
  end
end
