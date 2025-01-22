class BinaryTreeIterator
	include Enumerable

	attr_accessor :root

	def initialize(root)
		self.root = root
	end

	def each(&block)
		self.enumerator.each(&block)
	end

	private

	def enumerator
		Enumerator.new do |yielder|
			traverse_tree(self.root) { |data| yielder << data }
		end
	end

	def traverse_tree(node, &block)
		if node.nil?
			return
		end
		traverse_tree(node.left, &block)
		yield node.data
		traverse_tree(node.right, &block)
	end
end
