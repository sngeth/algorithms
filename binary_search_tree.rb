class Tree
  attr_accessor :item, :parent, :left, :right
end

class BinarySearchTree
  def search_tree(tree, x)
    if tree == nil
      return nil
    end

    if tree.item == x
      return tree
    end

    if x < tree.item
      return search_tree(tree.left, x)
    else
      return search_tree(tree.right, x)
    end
  end
end
