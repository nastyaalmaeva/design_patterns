require_relative 'data_list.rb'
require_relative 'data_table.rb'

class DataListStudentShort < DataList
	def get_names
		return ["№", "surname_with_initials", "git", "contact"]
	end
	
	def get_data
		index = 1
		result = [self.get_names]
		selected = self.selected
		selected.each do |selected_index|
			selected_obj = self.data[selected_index]
			row = [index, selected_obj.surname_with_initials, selected_obj.git, selected_obj.contact]
			result.append(row)
			index += 1
		end
		return DataTable.new(result)
	end
end