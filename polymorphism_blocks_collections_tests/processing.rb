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
end
