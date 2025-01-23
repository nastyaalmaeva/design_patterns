require 'pg'
require 'date'
require_relative '../student_classes/student.rb'
require_relative '../student_classes/student_short.rb'

class StudentsListDB
	def initialize(connection)
		@connection = connection
	end
	
	def get_student_by_id(required_id)
		result = @connection.exec_params("SELECT * FROM students WHERE student_id = $1", [required_id])
		if result.ntuples == 0
			return nil
		end
		row = result[0].transform_keys(&:to_sym)
		row[:student_id] = row[:student_id].to_i if row[:student_id]
		row[:birthdate] = Date.parse(row[:birthdate]).strftime('%d.%m.%Y') if row[:birthdate]
		return Student.new_from_hash(row)
	end
	
	def get_k_n_student_short_list(page_number, page_size, previous_data_list = nil)
		 if page_number < 1 || page_size <= 0
			raise ArgumentError, "Invalid arguments. 'page_number' must be greater than 0 and 'page_size' must be positive."
		end
		
		offset = (page_number - 1) * page_size
		result = @connection.exec_params("SELECT * FROM students ORDER BY student_id LIMIT $1 OFFSET $2", [page_size, offset])
		
		student_short_objects = result.map do |row|
			row = row.transform_keys(&:to_sym)
			row[:student_id] = row[:student_id].to_i if row[:student_id]
			StudentShort.new_from_student_object(Student.new_from_hash(row))
		end
		
		if previous_data_list.nil?
			return DataListStudentShort.new(student_short_objects)
		else
			previous_data_list.data = student_short_objects
			return previous_data_list
		end
	end
	
	def add_student(student_to_add)
		if not student_to_add.is_a?(Student)
			raise ArgumentError, "Invalid argument: Expected a Student object."
		end
		@connection.exec_params(
			"INSERT INTO students (surname, name, patronymic, phone_number, telegram, git, email_address, birthdate) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)",
			[
				student_to_add.surname,
				student_to_add.name,
				student_to_add.patronymic,
				student_to_add.phone_number,
				student_to_add.telegram,
				student_to_add.git,
				student_to_add.email_address,
				student_to_add.birthdate
			]
		)
	end
	
	def replace_student_by_id(required_id, new_student)
		if not new_student.is_a?(Student)
			raise ArgumentError, "Invalid argument: Expected a Student object."
		end
		
		result = @connection.exec_params("SELECT student_id FROM students WHERE student_id = $1", [required_id])
		if result.ntuples == 0
			raise ArgumentError, "Student with ID #{required_id} not found."
		end
		
		@connection.exec_params(
			"UPDATE students SET surname = $1, name = $2, patronymic = $3, phone_number = $4, telegram = $5, git = $6, email_address = $7, birthdate = $8 WHERE student_id = $9",
			[
				new_student.surname,
				new_student.name,
				new_student.patronymic,
				new_student.phone_number,
				new_student.telegram,
				new_student.git,
				new_student.email_address,
				new_student.birthdate,
				required_id
			]
		)
	end
	
	def delete_student_by_id(required_id)
		if get_student_by_id(required_id).nil?
			raise IndexError, "Student with ID #{required_id} not found."
		end
		@connection.exec_params("DELETE FROM students WHERE student_id = $1", [required_id])
	end
	
	def get_student_short_count
		result = @connection.exec("SELECT COUNT(*) AS count FROM students")
		return result[0]['count'].to_i
	end
	
	private
	
	attr_reader :connection
end