require_relative '../student_classes/student.rb'
require_relative '../student_classes/student_short.rb'
require_relative '../data_presentation/data_list_student.rb'

class StudentsList
	attr_accessor :strategy
	
	def initialize(strategy)
		self.strategy = strategy
		self.students = []
	end
	
	def get_student_by_id(id)
		return self.students.find { |student| student.student_id == id }
	end
	
	def get_k_n_objects_list(page_number, page_size, existing_data_list = nil)
		if page_number < 1 || page_size <= 0
			raise StandardError, "Invalid arguments: page_number must be greater than 0, and page_size must be positive."
		end
		start_index = (page_number - 1) * page_size
		selected_students = self.students[start_index, page_size]
		if selected_students.nil?
			selected_students = []
		end
		# student_short_objects = selected_students.map { |student| StudentShort.new_from_student_object(student) }
		if existing_data_list.nil?
			existing_data_list = DataListStudent.new(selected_students)
		else
			existing_data_list.data = selected_students
		end
		return existing_data_list
	end
	
	def sort_by_surname_with_initials!
        self.students.sort_by! { |student| student.surname_with_initials }
    end
	
	def add_student(new_student)
		if !new_student.is_a?(Student)
			raise StandardError, "Invalid argument: Expected a Student object."
		end
		if self.students.any? { |existing_student| existing_student == new_student }
			raise StandardError, "Student with similar git or contact already exists."
		end
		existing_ids = self.students.map { |student| student.student_id }
		if existing_ids.empty?
			highest_student_id = 0
		else
			highest_student_id = existing_ids.max
		end
		new_student.student_id = highest_student_id + 1
		self.students << new_student
	end
	
	def replace_student(required_student_id, new_student)
        index = self.students.find_index { |student| student.student_id == required_student_id }
		if index.nil?
			raise StandardError, "Student with ID #{required_student_id} not found."
		end
		new_student.student_id = required_student_id
		self.students[index] = new_student
    end
	
	def delete_student_by_id(student_id)
		index = self.students.find_index { |student| student.student_id == student_id }
		if index.nil?
			raise StandardError, "Student with ID #{student_id} not found."
		end
		self.students.delete_at(index)
	end
	
	def get_student_short_count
		return self.students.size
	end
	
	def read_from_file(file_path)
		read_students = self.strategy.read_from_file(file_path)
		read_students.map { |student| add_student(student) }
	end
	
	def write_to_file(file_path)
		self.strategy.write_to_file(file_path, self.students)
	end
	
	private
	
	attr_accessor :students
end