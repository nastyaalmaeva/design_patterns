require './binary_tree_iterator'
require './tree_node.rb'

class BinaryTree
	attr_accessor :root
	
	def initialize(&comparator)
		self.root = nil
		if block_given?
			@comparator = comparator
		else
			@comparator = Proc.new { |a, b| a <=> b }
		end
	end
	
	def iterator
		BinaryTreeIterator.new(self.root)
	end
	
	def insert(data)
		begin
			self.class.valid_node?(data, self.root)
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
	
	def self.valid_node?(data, root)
		if data.nil?
			raise ArgumentError, "Data cannot be nil"
		end
		if !root.nil?
			if !data.is_a?(root.data.class)
				raise ArgumentError, "All nodes must be of the same class"
			end
		end
	end
	
	def insert_node(previous_node, data)
		if compare(data, previous_node.data) < 0
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
	
	def compare(a, b)
		@comparator.call(a, b)
	end
end
