require "./math_helper.rb"

class Processing
	def self.find_count_of_elements_after_max_element(array)
		max_element = array.max { |a, b| a <=> b }
		max_elem_index = array.rindex { |element| element == max_element }
		return array.size - max_elem_index - 1
	end

	def self.replace_elements_before_min_element(array)
		min_element = array.min { |a, b| a <=> b }
		min_elem_index = array.index { |element| element == min_element }
		return array.rotate(min_elem_index)
	end

	def self.find_max_element_in_interval(array, range_start, range_end)
		elements_in_range = array.select { |x| x >= range_start && x <= range_end }
		max_element = elements_in_range.max { |a, b| a <=> b }
		return max_element
	end

	def self.find_elements_less_than_left_neighbor(array)
		array_of_indices = (1...array.size).select { |i| array[i] < array[i - 1] }
		return array_of_indices
	end

	def self.find_unique_prime_factors(array)
		prime_factors_array = array.flat_map { |num| MathHelper.prime_factors(num) }
		return prime_factors_array.uniq
	end
end
