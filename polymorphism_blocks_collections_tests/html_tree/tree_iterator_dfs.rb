require './tree_iterator.rb'

class TreeIteratorDFS < TreeIterator
	private

	def enumerator
		Enumerator.new do |yielder|
			stack = [self.root]
			while not stack.empty?
				current = stack.pop
				yielder << current
				if not current.children.nil?
					current.children.reverse.each { |child| stack.push(child) }
				end
			end
		end
    end
end
