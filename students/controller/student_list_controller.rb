require_relative '../data_strategy/students_list.rb'
require_relative '../data_strategy/json_strategy.rb'
require_relative '../model/data_list_student.rb'

class StudentListController
	def initialize(view)
		self.view = view
		begin
			file_path = 'students.json'
			
			if !File.exist?(file_path)
				raise "Файл #{file_path} не найден."
			end
			
			self.student_list = StudentsList.new(JSONStrategy.new)
			self.student_list.read_from_file(file_path)
			self.data_list = DataListStudent.new([])
			self.data_list.add_observer(self.view)
		rescue Exception => ex
			puts "Error: #{ex.message}"
			raise
		end
	end
	
	def refresh_data
		self.data = self.student_list.get_k_n_objects_list(self.view.current_page_label, self.view.class::ROWS_PER_PAGE)
		self.data_list.count = self.student_list.get_student_short_count
		self.data_list.notify(self.data)
	end
	
	def add
		puts "Добавление нового студента"
	end
	
	def delete(indexes)
		puts "Удаление записей с индексами: #{indexes}"
	end
	
	def update(index)
		puts "Изменение записи с индексом: #{index}"
	end
	
	private
	
	attr_accessor :view, :student_list, :data_list, :data
end
