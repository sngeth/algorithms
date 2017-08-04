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

  def swap_head(head, n)
    # find the nth and nth-1 node
    curr = head
    prev = nil

    return head if !head || n == 1

    count = 1
    # curr will become the nth node
    while(curr && count < n)
      prev = curr
      curr = curr.next
      count += 1
    end

    return head if !curr

    # point n-1 node to original head
    prev.next = head
    # save original head's pointer so the new current we can point to it later
    temp = head.next
    # point original head's next to nth node's next
    head.next = curr.next
    # point new head's next to old head's next
    curr.next = temp

    @head = curr
  end

  def merge_sorted(head1, head2)
    # empty lists check
    return head2 if !head1
    return head1 if !head2

    merged_head = nil

    # add first smallest item from each list and move to next item
    if head1.data <= head2.data
      merged_head = head1
      head1 = head1.next
    else
      merged_head = head2
      head2 = head2.next
    end

    # tail starts as head on first iteration
    merged_tail = merged_head

    # walk through each list and compare
    while (head1 && head2)
      temp = nil
      # first list's item is smaller so save it to add to merged_tail list
      if head1.data <= head2.data
        temp = head1
        head1 = head1.next
      # second list's item is smaller
      else
        temp = head2
        head2 = head2.next
      end

      merged_tail.next = temp
      merged_tail = temp
    end

    # append rest of list if 1 is completely consumed
    if head1
      merged_tail.next = head1
    elsif head2
      merged_tail.next = head2
    end

    @head = merged_head
  end

  def merge_alternating(list1, list2)
    return list if (!list1)
    return list1 if (!list2)

    head = list1

    while (list1.next && list2)
      temp = list2
      list2 = list2.next

      temp.next = list1.next
      list1.next = temp
      list1 = temp.next
    end

    list1.next = list2 if !list1.next

    head
  end

  def reverse_even_nodes
    # Let's extract even nodes from the existing
    # list and create a new list consisting of
    # even nodes. We will push the even nodes at
    # head since we want them to be in reverse order.

    curr = @head
    list_even = nil

    while curr && curr.next
      even = curr.next
      curr.next = even.next

      # Push at the head of new list.
      even.next = list_even
      list_even = even

      curr = curr.next
    end

    # Now, merge the two lists
    # Original: 1,2,3,4,5
    # Modified original: 1,3,5
    # List_even: 4,2
    # Merged: 1,4,3,2,5

    return merge_alternating(@head, list_even)
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

  describe "#swap_head" do
    it "swaps the nth node with head and returns head of new linked list" do
      list = LinkedList.new(Node.new(7, nil))
      list.add(14)
      list.add(21)
      list.add(28)
      list.add(35)
      list.add(42)

      new_head = list.swap_head(list.head, 4)
      new_head.data.must_equal 28

      LinkedList.new(new_head).to_s.must_equal "[28, 14, 21, 7, 35, 42]"
    end
  end

  describe "#merge_sorted" do
    it "takes two sorted linked lists and merges them into a single list" do
      list = LinkedList.new(Node.new(4, nil))
      list.add 8
      list.add 15
      list.add 19

      list2 = LinkedList.new(Node.new(7, nil))
      list2.add 9
      list2.add 10
      list2.add 16

      merged_list_head = list.merge_sorted(list.head, list2.head)
      LinkedList.new(merged_list_head).to_s.must_equal "[4, 7, 8, 9, 10, 15, 16, 19]"
    end
  end

  describe "#reverse_even_nodes" do
    it "given a singly linked list reverses nodes at even indices" do
      list = LinkedList.new(Node.new(7, nil))
      list.add 14
      list.add 21
      list.add 28
      list.add 9

      reversed_list_head = list.reverse_even_nodes
      LinkedList.new(reversed_list_head).to_s.must_equal "[7, 28, 21, 14, 9]"

    end
  end
end
