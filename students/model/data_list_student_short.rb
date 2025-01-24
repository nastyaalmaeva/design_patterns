require_relative 'data_list.rb'
require_relative 'data_table.rb'

class DataListStudentShort < DataList
	attr_accessor :start_index
	public :data=
	
	def get_names
		return ["№", "surname_with_initials", "git", "contact"]
	end
	
	private
	
	def build_row(index, student_short_obj)
		return [index + (start_index || 0) + 1, student_short_obj.surname_with_initials, student_short_obj.git, student_short_obj.contact]
	end
end