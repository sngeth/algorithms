require "minitest/autorun"
require "set"
require "byebug"

Node = Struct.new(:data, :next)

class LinkedList
  attr_accessor :head

  def initialize(head)
    @head = head
  end

  def add(data)
    current = @head

    while !current.next.nil?
      current = current.next
    end
    current.next = Node.new(data, nil)
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

  def sorted_insert(head, node)
    if !head || node.data <= head.data
      node.next = head
      return node
    end

    curr = head
    while curr.next && curr.next.data < node.data
      curr = curr.next
    end

    node.next = curr.next
    curr.next = node

    head
  end

  def insertion_sort(head)
    sorted = nil
    curr = head

    while curr
      temp = curr.next
      sorted = sorted_insert(sorted, curr)
      curr = temp
    end

    @head = sorted
  end

  def delete(head, key)
    prev = nil
    curr = head

    while curr
      break if curr.data == key

      prev = curr
      curr = curr.next
    end

    # reached end of list without finding
    return head if !curr

    # node to be deleted is head node
    return head.next if curr == head

    # connect previous node to what deleted node pointed to
    prev.next = curr.next

    head
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

  def self.intersect(head1, head2)
    list1node = list2node = nil
    list1length = get_length(head1)
    list2length = get_length(head2)

    length_difference = 0
    if list1length >= list2length
      length_difference = list1length - list2length
      list1node = head1
      list2node = head2
    else
      length_difference = list2length - list1length
      list1node = head2
      list2node = head1
    end

    # move shorter list to same position as longer list
    while length_difference > 0
      list1node = list1node.next
      length_difference -= 1
    end

    while list1node
      if list1node == list2node
        return list1node
      end

      list1node = list1node.next
      list2node = list2node.next
    end

    nil
  end

  def self.get_length(head)
    length = 0

    while head
      head = head.next
      length += 1
    end

    length
  end

  def nth_from_last(head, n)
    if !head || n < 1
      return nil
    end

    tail = head
    while tail && n > 0
      tail = tail.next
      n -= 1
    end

    return nil if n != 0

    while tail
      tail = tail.next
      head = head.next
    end

    @head = head
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

  describe "#delete" do
    it "deletes node with given key" do
      f = Node.new(41, nil)
      e = Node.new(72, f)
      d = Node.new(11, e)
      c = Node.new(36, d)
      b = Node.new(14, c)
      head = Node.new(20, b)

      linked_list = LinkedList.new(head)
      linked_list.delete(head, 72)
      linked_list.to_s.must_equal "[20, 14, 36, 11, 41]"
    end
  end

  describe "#insertion_sort" do
    it "sorts list" do
      d = Node.new(11, nil)
      c = Node.new(82, d)
      b = Node.new(23, c)
      head = Node.new(29, b)

      linked_list = LinkedList.new(head)
      linked_list.insertion_sort(head)
      linked_list.to_s.must_equal "[11, 23, 29, 82]"
    end
  end

  describe "#intersect" do
    it "returns point of intersection" do
      list1 = LinkedList.new(Node.new(29, nil))
      list1.add(23)
      list1.add(82)
      list1.add(11)
      list1.add(12)
      list1.add(27)

      list2 = LinkedList.new(Node.new(13, nil))
      list2.add(4)
      list2.add(12)
      list2.add(27)

      intersection = LinkedList.intersect(list1.head, list2.head)
      intersection.data.must_equal 12
    end
  end

  describe "#nth_from_last_node" do
    it "returns ref to nth from last node" do
      list = LinkedList.new(Node.new(7, nil))
      list.add(14)
      list.add(21)
      list.add(28)
      list.add(35)
      list.add(42)

      third_from_last = list.nth_from_last(list.head, 3)
      third_from_last.data.must_equal 28
      LinkedList.new(third_from_last).to_s.must_equal "[28, 35, 42]"
    end
  end
end
