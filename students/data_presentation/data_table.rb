class DataTable
	def initialize(data)
		self.data = data
	end
	
	def row_count
		return self.data.size - 1
	end
	
	def column_count
		if data.empty?
			return 0
		else
			return data[0].size
		end
	end
	
	def get_element(row_index, column_index)
		if !valid_row_index?(row_index)
			raise IndexError, "Row index out of bounds"
		end
		if !valid_column_index?(column_index)
			raise IndexError, "Column index out of bounds"
		end
		return self.data[row_index][column_index]
	end
	
	def to_s
		if data.empty?
			return "Empty table"
		else
			output = "╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗\n"
			data.each do |row|
				formatted_row = row.map.with_index do |cell, index|
					if index == 0
						format('%-3s', cell ? cell : 'No data')
					else
						format('%-35s', cell ? cell : 'No data')
					end
				end
				output += " #{formatted_row.join(' | ')}\n"
			end
			output += "╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝"
		end
		return output
	end
	
	def update_data(new_data)
		if !new_data.is_a?(Array) || !new_data.all? { |row| row.is_a?(Array) }
			raise ArgumentError, "Data must be a two-dimensional array"
		else
			self.data[1..-1] = new_data.map { |element| element.dup }
		end
	end
	
	private
	
	attr_reader :data
	
	def data=(data)
		if !data.is_a?(Array) || !data.all? { |row| row.is_a?(Array) }
			raise ArgumentError, "Data must be a two-dimensional array"
		else
			@data = data.map { |element| element.dup }
		end
	end
	
	def valid_row_index?(row_index)
		if row_index < 0 || row_index >= row_count
			return false
		else
			return true
		end
	end
	
	def valid_column_index?(column_index)
		if column_index < 0 || column_index >= column_count
			return false
		else
			return true
		end
	end
end