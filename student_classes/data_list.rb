require_relative 'data_table.rb'

class DataList
	def initialize(data)
		self.data = data
		self.selected = []
	end
	
	def select(number)
		if !number.is_a?(Integer)
			raise ArgumentError, "Index must be an integer"
		end
		if number < 0 || number >= data.size
			raise IndexError, "Element with index #{number} does not exist"
		end
		element = self.data[number]
		if !get_selected.include?(number)
			get_selected << number
		end
		return element
	end
	
	def get_selected
		return @selected
	end
	
	def clear_selected
		self.selected = []
	end
	
	def get_data
		headers = get_names
		rows = get_rows
		return DataTable.new(headers, rows)
	end
	
	protected
	
	attr_reader :data
	attr_writer :selected
	
	def get_names
		raise NotImplementedError, "Method not implemented in the DataList class"
	end
	
	def build_row
		raise NotImplementedError, "Method not implemented in the DataList class"
	end
	
	def get_rows
		row_index = 1
		rows = []
		selected_indixes = get_selected
		selected_indixes.each do |selected_index|
			selected_obj = self.data[selected_index]
			row_data = build_row(row_index, selected_obj)
			rows.append(row_data)
			row_index += 1
		end
		return rows
	end
	
	private
	
	def data=(data)
		if !data.is_a?(Array)
			raise ArgumentError, "Data must be an array"
		else
			@data = data
		end
	end
end