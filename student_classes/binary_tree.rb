require './binary_tree_iterator'
require './tree_node.rb'

class BinaryTree
	attr_accessor :root

	def initialize(&comparator)
		self.root = nil
		@comparator = comparator || ->(a, b) { a <=> b }
	end

	def iterator
		BinaryTreeIterator.new(self.root)
	end

	def insert(data)
		if self.root.nil?
			self.root = TreeNode.new(data)
			return
		end
		insert_node(self.root, data)
	end

	private

	def insert_node(previous_node, data)
		if compare(data, previous_node.data) < 0
			if previous_node.left.nil?
				previous_node.left = TreeNode.new(data)
				return
			end
			insert_node(previous_node.left, data)
			return
		end
		if previous_node.right.nil?
			previous_node.right = TreeNode.new(data)
			return
		end
		insert_node(previous_node.right, data)
	end

	def compare(a, b)
		@comparator.call(a, b)
	end
end
