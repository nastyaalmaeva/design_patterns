class DataList
	attr_reader :data
	attr_accessor :selected
	
	def initialize(data)
		self.data = data
		self.selected = []
	end
	
	def select(number)
		if !number.is_a?(Integer)
			raise ArgumentError, "Index must be an integer"
		elsif number < 0 || number >= data.size
			raise IndexError, "Element with index #{number} does not exist"
		else
			element = self.data[number]
			if !self.selected.include?(number)
				self.selected << number
			end
			return element
		end
	end
	
	def get_selected
		self.selected
	end
	
	def get_names
		raise NotImplementedError, "Method not implemented in the DataList class"
	end
	
	def get_data
		raise NotImplementedError, "Method not implemented in the DataList class"
	end
	
	private
	
	def data=(data)
		if !data.is_a?(Array)
			raise ArgumentError, "Data must be an array"
		else
			@data = data.sort
		end
	end
end