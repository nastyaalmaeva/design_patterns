class ArrayProcessor
	def initialize(array)
		self.array = array.dup
	end

	# Проверяет, удовлетворяет ли хотя бы один элемент условию блока
	def any?
		self.array.each do |element|
			return true if yield(element)
		end
		false
	end

	# Возвращает массив всех элементов, удовлетворяющих условию блока
	def find_all
		result = []
		self.array.each do |element|
			result << element if yield(element)
		end
		result
	end

	def to_a
		self.array.dup
	end

	private

	attr_accessor :array
end
