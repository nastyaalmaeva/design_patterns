require_relative 'data_list.rb'
require_relative 'data_table.rb'

class DataListStudent < DataList
	attr_accessor :start_index
	public :data=
	
	def get_names
		return ["№", "surname_with_initials", "phone_number", "telegram", "email_address", "git"]
	end
	
	private
	
	def build_row(index, student_obj)
		return [index + (start_index || 0) + 1, student_obj.surname_with_initials, student_obj.phone_number, student_obj.telegram, student_obj.email_address, student_obj.git]
	end
end