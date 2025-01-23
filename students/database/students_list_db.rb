require 'pg'
require 'date'
require_relative 'db_client.rb'
require_relative '../student_classes/student.rb'
require_relative '../student_classes/student_short.rb'

class StudentsListDB
	def get_student_by_id(required_id)
		result = DBClient.instance.execute("SELECT * FROM students WHERE student_id = $1", [required_id])
		if result.ntuples == 0
			return nil
		end
		hash = process_hash(result[0])
		return Student.new_from_hash(hash)
	end
	
	def get_k_n_student_short_list(page_number, page_size, previous_data_list = nil)
		if page_number < 1 || page_size <= 0
			raise ArgumentError, "Invalid arguments. 'page_number' must be greater than 0 and 'page_size' must be positive."
		end
		
		start_index = (page_number - 1) * page_size
		result = DBClient.instance.execute("SELECT * FROM students ORDER BY student_id LIMIT $1 OFFSET $2", [page_size, start_index])
		
		student_short_objects = result.map do |hash|
			hash = process_hash(hash)
			StudentShort.new_from_student_object(Student.new_from_hash(hash))
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
		DBClient.instance.execute(
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
		result = DBClient.instance.execute("SELECT student_id FROM students WHERE student_id = $1", [required_id])
		if result.ntuples == 0
			raise ArgumentError, "Student with ID #{required_id} not found."
		end
		DBClient.instance.execute(
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
		DBClient.instance.execute("DELETE FROM students WHERE student_id = $1", [required_id])
	end
	
	def get_student_short_count
		result = DBClient.instance.execute("SELECT COUNT(*) AS count FROM students")
		return result[0]['count'].to_i
	end
	
	private
	
	def process_hash(hash)
		hash = hash.transform_keys(&:to_sym)
		if not hash[:student_id].nil?
			hash[:student_id] = hash[:student_id].to_i
		end
		if not hash[:birthdate].nil?
			hash[:birthdate] = Date.parse(hash[:birthdate]).strftime('%d.%m.%Y')
		end
		return hash
	end
end