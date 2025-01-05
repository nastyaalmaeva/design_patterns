require 'json'
require_relative './student.rb'
require_relative './student_short.rb'

class StudentsListJSON
	attr_accessor :file_path, :students
	
	def initialize(file_path)
        self.file_path = file_path
        self.students = []
    end
	
	def read_from_file
		if !File.exist?(self.file_path)
			return []
		else
			begin
				File.open(self.file_path, 'r') do |file|
					content = file.read
					
					if content.strip.empty?
						return []
					end
					
					data = JSON.parse(content, symbolize_names: true)
					
					if !data.is_a?(Array) || !data.all? { |entry| entry.is_a?(Hash) }
						raise StandardError, "Invalid JSON structure. Expected an array of hashes."
					end
					
					students = data.map { |entry| Student.new(**entry) }
					
					return students
				end
			rescue JSON::ParserError => e
				raise StandardError, "JSON parsing error: #{e.message}"
			end
		end
	end
	
	def write_to_file
		if self.students.nil? || !self.students.all? { |student| student.is_a?(Student) }
			raise StandardError, "The students list is not initialized or contains invalid entries"
		end
		
		if self.file_path.nil? || self.file_path.empty?
			raise StandardError, "The file path is not defined"
		end
		
		student_data = self.students.map { |student| student.to_h }
		
		begin
			File.open(self.file_path, 'w') do |file|
				file.write(JSON.pretty_generate(student_data))
			end
		rescue IOError => error
			raise StandardError, "Failed to write to file: #{error.message}"
		end
	end
	
	def get_student_by_id(id)
		return self.students.find { |student| student.student_id == id }
	end
	
	def get_k_n_student_short_list(page_number, page_size, existing_data_list = nil)
		if page_number < 1 || page_size <= 0
			raise StandardError, "Invalid arguments: page_number must be greater than 0, and page_size must be positive."
		end
		
		start_index = (page_number - 1) * page_size
		selected_students = self.students[start_index, page_size]
		if selected_students.nil?
			selected_students = []
		end
		student_short_objects = selected_students.map { |student| StudentShort.new_from_student_object(student) }
		
		if existing_data_list.nil?
			existing_data_list = DataListStudentShort.new(student_short_objects)
			existing_data_list.select_all
		end
		return existing_data_list
	end
	
	def sort_by_surname_with_initials!
        self.students.sort_by! { |student| student.surname_with_initials }
    end
end