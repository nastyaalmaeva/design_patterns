class Processing
	def self.find_count_of_elements_after_max_element(array)
		max_element = array.max { |a, b| a <=> b }
		max_elem_index = array.rindex { |element| element == max_element }
		return array.size - max_elem_index - 1
	end
end
