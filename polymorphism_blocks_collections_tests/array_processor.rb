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

	# Возвращает индекс первого элемента, удовлетворяющего условию блока
	def find_index
		self.array.each_with_index do |element, index|
			return index if yield(element)
		end
		nil
	end

	# Возвращает минимальный и максимальный элементы в массиве
	def min_max
		return [nil, nil] if self.array.empty?

		min_element = max_element = self.array[0]
		self.array.each do |element|
			min_element = element if yield(element, min_element) < 0
			max_element = element if yield(element, max_element) > 0
		end
		[min_element, max_element]
	end

	# Проверяет, не удовлетворяет ли ни один элемент условию блока
	def none?
		self.array.each do |element|
			return false if yield(element)
		end
		true
	end

	def to_a
		self.array.dup
	end

	private

	attr_accessor :array
end
