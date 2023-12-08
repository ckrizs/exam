class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinaryTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_recursive(@root, value)
  end

  def delete(value)
    @root = delete_recursive(@root, value)
  end

  def inorder_traversal
    inorder_traversal_recursive(@root)
  end

  private

  def insert_recursive(node, value)
    return TreeNode.new(value) if node.nil?

    if value < node.value
      node.left = insert_recursive(node.left, value)
    elsif value > node.value
      node.right = insert_recursive(node.right, value)
    end

    node
  end

  def delete_recursive(node, value)
    return nil if node.nil?

    if value < node.value
      node.left = delete_recursive(node.left, value)
    elsif value > node.value
      node.right = delete_recursive(node.right, value)
    else

      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end

      node.value = find_min_value(node.right)

      node.right = delete_recursive(node.right, node.value)
    end

    node
  end

  def find_min_value(node)
    min_value = node.value
    while node.left
      min_value = node.left.value
      node = node.left
    end
    min_value
  end

  def inorder_traversal_recursive(node)
    return [] if node.nil?

    left = inorder_traversal_recursive(node.left)
    current = [node.value]
    right = inorder_traversal_recursive(node.right)

    left + current + right
  end
end

tree = BinaryTree.new
tree.insert(5)
tree.insert(3)
tree.insert(7)
tree.insert(2)
tree.insert(4)

puts "Inorder Traversal: #{tree.inorder_traversal}"

tree.delete(3)

puts "Inorder Traversal after deletion: #{tree.inorder_traversal}"