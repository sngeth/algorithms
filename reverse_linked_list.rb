require "minitest/autorun"

Node = Struct.new(:data, :next)

class LinkedList
  attr_accessor :head

  def initialize(head)
    @head = head
  end

  def reverse_iterative(head)
    if !head || !head.next
      return head
    end

    list_to_do = head.next

    # create a new reversed list
    # point it initially to beginning of old list
    reversed_head = head
    reversed_head.next = nil

    # At each iteration, the list_to_do pointer moves forward
    # The current node becomes the head of the new reversed linked list and
    # starts pointing to the previous head of the reversed linked list.
    while list_to_do
      temp = list_to_do
      list_to_do = list_to_do.next

      temp.next = reversed_head
      reversed_head = temp
    end

    @head = reversed_head
  end

  def reverse_recursive(head)
    return head if !head || !head.next

    reversed_head = reverse_recursive(head.next)

    head.next.next = head
    head.next = nil
    @head = reversed_head
  end
end

describe LinkedList do
  before do
    d = Node.new(28, nil)
    c = Node.new(21, d)
    b = Node.new(14, c)
    @head = Node.new(7, b)
    @linked_list = LinkedList.new(@head)
  end

  describe "#reverse_iterative" do
    it "iteratively returns reference to head of reversed list" do
      @linked_list.reverse_iterative(@head)
      @linked_list.head.data.must_equal 28
      @linked_list.head.next.data.must_equal 21
      @linked_list.head.next.next.data.must_equal 14
      @linked_list.head.next.next.next.data.must_equal 7
    end
  end

  describe "#reverse_recursive" do
    it "recursively returns reference to head of reversed list" do
      @linked_list.reverse_recursive(@head)
      @linked_list.head.data.must_equal 28
      @linked_list.head.next.data.must_equal 21
      @linked_list.head.next.next.data.must_equal 14
      @linked_list.head.next.next.next.data.must_equal 7
    end
  end
end
