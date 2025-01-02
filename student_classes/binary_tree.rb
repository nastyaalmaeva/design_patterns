require './binary_tree_iterator'
require './tree_node.rb'

class BinaryTree
	attr_accessor :root
	
	def initialize
		self.root = nil
	end
	
	def iterator
		BinaryTreeIterator.new(self.root)
	end
	
	def insert(data)
		begin
			valid_node?(data)
			if self.root.nil?
				self.root = TreeNode.new(data)
			else
				insert_node(self.root, data)
			end
		rescue => e
			puts "Error while inserting node: #{e.message}"
		end
	end
	
	private
	
	def valid_node?(data)
		if data.nil?
			raise ArgumentError, "Data cannot be nil"
		end
		if !self.root.nil? && !self.root.data.is_a?(data.class)
			raise ArgumentError, "All nodes must be of the same class as the root node"
		end
	end
	
	def insert_node(previous_node, data)
		if data < previous_node.data
			if previous_node.left.nil?
				previous_node.left = TreeNode.new(data)
			else
				insert_node(previous_node.left, data)
			end
		elsif previous_node.right.nil?
			previous_node.right = TreeNode.new(data)
		else
			insert_node(previous_node.right, data)
		end
	end
end
