require 'json'
require_relative './student.rb'
require_relative './student_short.rb'
require_relative './students_list.rb'

class StudentsListJSON < StudentsList
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
					self.students = []
					data.each { |entry| add_student(Student.new(**entry)) }
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
end