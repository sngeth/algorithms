require "minitest/autorun"
require "set"
require "byebug"

Node = Struct.new(:data, :next)

class LinkedList
  attr_accessor :head

  def initialize(head)
    @head = head
  end

  def to_s
    curr = head
    ll = []

    while curr
      ll << curr.data
      curr = curr.next
    end

    ll.to_s
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

  def remove_dups
    return head if !head

    dups = Set.new
    dups.add(head.data)
    curr = head

    while curr.next
      if dups.include?(curr.next.data)
        curr.next = curr.next.next
      else
        dups.add(curr.next.data)
        curr = curr.next
      end
    end

    head
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

  describe "#remove_dups" do
    it "head reference to list with no duplicates" do
      g = Node.new(4, nil)
      f = Node.new(11, g)
      e = Node.new(7, f)
      d = Node.new(9, e)
      c = Node.new(4, d)
      b = Node.new(7, c)
      head = Node.new(4, b)

      linked_list = LinkedList.new(head)
      linked_list.remove_dups
      linked_list.to_s.must_equal "[4, 7, 9, 11]"
    end
  end
end
