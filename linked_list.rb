class Node
  attr_accessor :data, :next_node

  def initialize(data, next_node = nil)
    @data = data
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :head

  def add_first(item)
    @head = Node.new(item, head)
  end

  def traverse
    temp_node = head
    arr = []

    while temp_node != nil do
      arr << temp_node.data
      temp_node = temp_node.next_node
    end

    arr
  end

  def add_last(item)
    if(head == nil)
      add_first(item)
    else
      temp_node = head

      while(temp_node.next_node != nil) do
        temp_node = temp_node.next_node
      end

      temp_node.next_node = Node.new(item, nil)
    end
  end

  def insert_after(key, value)
    temp_node = head

    while(temp_node != nil && !(temp_node.data == key)) do
      temp_node = temp_node.next
    end

    temp_node.next_node = Node.new(value, temp_node.next_node) if temp_node != nil
  end

  def insert_before(key, node_to_insert)
    return nil if head == nil

    if(head.data == key)
      return add_first(node_to_insert)
    end

    prev = nil
    cur = head

    while(cur != nil && !(cur.data == key)) do
      prev = cur
      cur = cur.next_node
    end

    prev.next_node = Node.new(node_to_insert, cur) if cur != nil
  end

  def remove(key)
    raise "Cannot delete" if @head == nil

    if(@head.data == key)
      @head = head.next_node
      return
    end

    cur = head
    prev = nil

    while(cur != nil && !(cur.data == key)) do
      prev = cur
      cur = cur.next_node
    end

    raise "Cannot delete" if(cur == nil)

    prev.next_node = cur.next_node
  end
end
