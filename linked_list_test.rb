require "minitest/autorun"
require "./linked_list"
require "byebug"

class LinkedListTest < Minitest::Test
  def setup
    @linked_list = LinkedList.new
  end

  def test_add_first
    @linked_list.add_first("first item")

    assert_equal "first item", @linked_list.head.data
  end

  def test_add_last
    @linked_list.add_first("first item")
    @linked_list.add_last("last item")

    assert_equal "last item", @linked_list.head.next_node.data
  end

  def test_traverse
    @linked_list.add_first("first item")
    @linked_list.add_last("second item")

    list = ["first item", "second item"]
    assert_equal list, @linked_list.traverse
  end

  def test_insert_after
    @linked_list.add_first("first item")
    @linked_list.add_last("last item")

    @linked_list.insert_after("first item", "second item")

    list = ["first item", "second item", "last item"]
    assert_equal list, @linked_list.traverse
  end

  def test_insert_before
    @linked_list.add_first("first item")
    @linked_list.insert_before("first item", "second item")

    list = ["second item", "first item"]
    assert_equal list, @linked_list.traverse
  end

  def test_remove
    @linked_list.add_first("first item")
    @linked_list.add_first("second item")
    @linked_list.remove("second item")

    assert_equal ["first item"], @linked_list.traverse
  end
end
