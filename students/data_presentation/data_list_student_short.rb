require_relative 'data_list.rb'
require_relative 'data_table.rb'

class DataListStudentShort < DataList
	public :data=
	def get_names
		return ["№", "surname_with_initials", "git", "contact"]
	end
	
	private
	
	def build_row(student_short_obj)
		return [student_short_obj.student_id, student_short_obj.surname_with_initials, student_short_obj.git, student_short_obj.contact]
	end
end