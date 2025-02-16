require 'json'
require_relative '../student_classes/student.rb'
require_relative '../student_classes/student_short.rb'
require_relative 'file_strategy.rb'

class JSONStrategy < FileStrategy
	def read_from_file(file_path)
		if !File.exist?(file_path)
			return []
		else
			begin
				File.open(file_path, 'r') do |file|
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
	
	def write_to_file(file_path, students)
		if students.nil? || !students.all? { |student| student.is_a?(Student) }
			raise StandardError, "The students list is not initialized or contains invalid entries"
		end
		if file_path.nil? || file_path.empty?
			raise StandardError, "The file path is not defined"
		end
		student_data = students.map { |student| student.to_h }
		begin
			File.open(file_path, 'w') do |file|
				file.write(JSON.pretty_generate(student_data))
			end
		rescue IOError => error
			raise StandardError, "Failed to write to file: #{error.message}"
		end
	end
end