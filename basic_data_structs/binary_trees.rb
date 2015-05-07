class Node
  attr_reader :value
  attr_accessor :left_node, :right_node

  def initialize(value)
    @value = value
  end

  def link(new_node)
    if new_node < @value
      left_node.nil? ? self.left_node = Node.new(new_node) : left_node.link(new_node)
    else
      right_node.nil? ? self.right_node = Node.new(new_node) : right_node.link(new_node)
    end
  end
end

def build_tree(values)
  start_time = Time.now
  values = values.uniq.shuffle
  root = Node.new(values.shift)
  values.each { |value| root.link(value) }
  puts "\nBuilt Tree in #{(Time.now - start_time) * 1000} ns"
  root
end

def breadth_first_search(target, tree_node)
  start_time = Time.now
  queue = [tree_node]
  puts "\nBreadth searching for: #{target} in the tree..."
  until queue.empty?
    return "Found: #{queue.first.value} at Node: #{queue.first} in #{(Time.now - start_time) * 1000000} ns" if queue.first.value == target
    queue << queue.first.left_node unless queue.first.left_node.nil?
    queue << queue.first.right_node unless queue.first.right_node.nil?
    queue.shift
  end
end

def depth_first_search(target, tree_node)
  start_time = Time.now
  stack = [tree_node]
  checked = [tree_node]
  puts "\nDepth searching for: #{target} in the tree..."
  until stack.empty?
    return "Found: #{stack.last.value} at Node: #{stack.last} in #{(Time.now - start_time) * 1000000} ns" if stack.last.value == target
    if stack.last.left_node && !checked.include?(stack.last.left_node)
      stack << stack.last.left_node
      checked << stack.last
    elsif stack.last.right_node && !checked.include?(stack.last.right_node)
      stack << stack.last.right_node
      checked << stack.last
    else
      stack.pop
    end
  end
end

def dfs_rec(target, tree_node)
  return "Found: #{tree_node.value} at Node: #{tree_node}" if tree_node.value == target

  left_search = dfs_rec(target, tree_node.left_node) unless tree_node.left_node.nil?
  return left_search unless left_search.nil?
  right_search = dfs_rec(target, tree_node.right_node) unless tree_node.right_node.nil?
  return right_search unless right_search.nil?
end

tree = build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
#tree.to_a.each { |node| puts "Node: #{node} value: #{node.value} - #{node.left_node.value unless node.left_node.value.nil?} | #{node.right_node.value unless node.right_node.value.nil?}"  }
puts breadth_first_search(3, tree)
puts breadth_first_search(7, tree)
puts breadth_first_search(67, tree)
puts depth_first_search(3, tree)
puts depth_first_search(7, tree)
puts depth_first_search(67, tree)
puts ""
puts dfs_rec(3, tree)
puts dfs_rec(7, tree)
puts dfs_rec(67, tree)
