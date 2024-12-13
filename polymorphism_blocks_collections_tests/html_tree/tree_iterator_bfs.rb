require './tree_iterator.rb'

class TreeIteratorBFS < TreeIterator
	private

	def enumerator
		Enumerator.new do |yielder|
			queue = [self.root]
			while not queue.empty?
				current = queue.shift
				yielder << current
				if not current.children.nil?
					current.children.each { |child| queue.push(child) }
				end
			end
		end
	end
end
