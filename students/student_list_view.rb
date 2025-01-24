require 'fox16'
require_relative 'data_presentation/data_list_student'
require_relative 'data_presentation/data_table'
require_relative 'student_classes/student'

include Fox

class StudentListView < FXVerticalFrame
	
	ROWS_PER_PAGE = 4
	
	def initialize(parent)
		super(parent, opts: LAYOUT_FILL)
		self.filters = {}
		setup_filtering_area
		setup_table_area
		setup_control_buttons_area
	end
	
	def setup_filtering_area
		filtering_area = FXVerticalFrame.new(self, opts: LAYOUT_FILL_X | LAYOUT_SIDE_TOP)
		FXLabel.new(filtering_area, "ФИЛЬТРАЦИЯ:")
		surname_with_initials_text_label = "surname with initials:"
		surname_with_initials_text_field = nil
		FXHorizontalFrame.new(filtering_area, opts: LAYOUT_FILL_X) do |frame|
			surname_with_initials_label = FXLabel.new(frame, surname_with_initials_text_label, opts: LAYOUT_FIX_WIDTH, width: 125)
			FXFrame.new(frame, opts: LAYOUT_FIX_WIDTH, width: 20)
			surname_with_initials_text_field = FXTextField.new(frame, 50, opts: TEXTFIELD_NORMAL)
		end
		
		self.filters[surname_with_initials_text_label[0...-1]] = { text_field: surname_with_initials_text_field }
		add_filtering_row(filtering_area, "git:")
		add_filtering_row(filtering_area, "email address:")
		add_filtering_row(filtering_area, "phone number:")
		add_filtering_row(filtering_area, "telegram:")
		
		FXButton.new(filtering_area, "Очистить фильтрацию", opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
			reset_filters
		end
	end
	
	def add_filtering_row(parent, label)
		FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X) do |frame|
			FXLabel.new(frame, label, opts: LAYOUT_FIX_WIDTH, width: 100)
			FXFrame.new(frame, opts: LAYOUT_FIX_WIDTH, width: 5)
			
			combo_box = FXComboBox.new(frame, 3, opts: COMBOBOX_STATIC | FRAME_SUNKEN)
			combo_box.numVisible = 3
			combo_box.appendItem("НЕ ВАЖНО")
			combo_box.appendItem("ДА")
			combo_box.appendItem("НЕТ")
			
			FXFrame.new(frame, opts: LAYOUT_FIX_WIDTH, width: 10)
			
			text_field = FXTextField.new(frame, 40, opts: TEXTFIELD_NORMAL)
			text_field.enabled = false
			
			self.filters[label[0...-1]] = { combo_box: combo_box, text_field: text_field }
			
			combo_box.connect(SEL_COMMAND) do
				text_field.enabled = (combo_box.currentItem == 1)
			end
		end
	end
	
	def reset_filters
		self.filters.each do |key, field|
			field[:combo_box]&.setCurrentItem(0)
			field[:text_field]&.text = ""
			
			if key != 'surname with initials'
				field[:text_field]&.enabled = false
			end
		end
		update_table
	end
	
	def setup_table_area
		table_area = FXVerticalFrame.new(self, opts: LAYOUT_FILL)
		self.table = FXTable.new(table_area, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
		self.table.setTableSize(ROWS_PER_PAGE, 6)
		self.table.rowHeaderMode = LAYOUT_FIX_WIDTH
		self.table.rowHeaderWidth = 30
		(0...self.table.numColumns).each do |col_index|
			self.table.setColumnWidth(col_index, 200)
		end
		controls = FXHorizontalFrame.new(table_area, opts: LAYOUT_FILL_X)
		self.prev_button = FXButton.new(controls, "<<<", opts: BUTTON_NORMAL | LAYOUT_LEFT)
		self.current_page_label = FXLabel.new(controls, "Страница: 1/1", opts: LAYOUT_CENTER_X)
		self.next_button = FXButton.new(controls, ">>>", opts: BUTTON_NORMAL | LAYOUT_RIGHT)
		self.prev_button.connect(SEL_COMMAND) { switch_page(-1) }
		self.next_button.connect(SEL_COMMAND) { switch_page(1) }
		populate_table
	end
	
	def setup_control_buttons_area
		button_area = FXHorizontalFrame.new(self, opts: LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
		self.add_button = FXButton.new(button_area, "Добавить студента", opts: BUTTON_NORMAL)
		self.edit_button = FXButton.new(button_area, "Изменить студента", opts: BUTTON_NORMAL)
		self.delete_button = FXButton.new(button_area, "Удалить студента", opts: BUTTON_NORMAL)
		self.update_button = FXButton.new(button_area, "Обновить таблицу", opts: BUTTON_NORMAL)
		self.add_button.connect(SEL_COMMAND) { on_add }
		self.update_button.connect(SEL_COMMAND) { on_update }
		self.edit_button.connect(SEL_COMMAND) { on_edit }
		self.delete_button.connect(SEL_COMMAND) { on_delete }
		self.table.connect(SEL_SELECTED) { update_button_states }
		self.table.connect(SEL_DESELECTED) { update_button_states }
		update_button_states
	end
	
	private
	
	attr_accessor :table, :data_list, :data, :total_pages, :current_page, :current_page_label, :prev_button, :next_button, :sort_order, :add_button, :update_button, :edit_button, :delete_button, :filters
	
	def populate_table
		self.data_list = DataListStudent.new([
		first_student = Student.new(
		surname: "Almaeva",
		name: "Anastasia",
		patronymic: "Ilyinichna",
		student_id: 1,
		phone_number: "+7(905)-123-45-67",
		telegram: "@nastya",
		email_address: "nastya@gmail.com",
		git: "https://github.com/nastyaalmaeva",
		birthdate: "04.12.2005"),
		second_student = Student.new(
			surname: "Kuznetsov",
			name: "Dmitry",
			patronymic: "Nikolaevich",
			student_id: 2,
			telegram: "@dmitry_k",
			email_address: "dmitry.kuznetsov@gmail.com",
			git: "https://github.com/dmitry_kuznetsov",
			birthdate: "01.10.2001"),
		third_student = Student.new(
			surname: "Fedorov",
			name: "Maxim",
			patronymic: "Olegovich",
			student_id: 3,
			phone_number: "+7(925)-888-99-11",
			telegram: "@max_fed",
			git: "https://github.com/max_fedorov",
			birthdate: "15.05.1992"),
		fourth_student = Student.new(
			surname: "Ivanov",
			name: "Sergey",
			patronymic: "Viktorovich",
			student_id: 4,
			phone_number: "+7(910)-111-22-33",
			birthdate: "15.05.1995"),
		fifth_student = Student.new(
			surname: "Petrov",
			name: "Alexey",
			patronymic: "Dmitrievich",
			student_id: 5),
		sixth_student = Student.new(
			surname: "Sidorov",
			name: "Nikolay",
			patronymic: "Petrovich",
			student_id: 6,
			phone_number: "+7(901)-222-33-44",
			telegram: "@nikolay_sid",
			email_address: "nikolay.sidorov@gmail.com",
			git: "https://github.com/nikolay_sidorov",
			birthdate: "20.03.1993"),
		seventh_student = Student.new(
			surname: "Smirnov",
			name: "Ivan",
			patronymic: "Alexandrovich",
			student_id: 7,
			telegram: "@ivan_smirnov",
			email_address: "ivan.smirnov@gmail.com",
			git: "https://github.com/ivan_smirnov",
			birthdate: "18.07.1998"),
		eighth_student = Student.new(
			surname: "Popov",
			name: "Artem",
			patronymic: "Igorevich",
			student_id: 8,
			phone_number: "+7(902)-333-44-55",
			email_address: "artem.popov@gmail.com",
			birthdate: "12.02.1997"),
		ninth_student = Student.new(
			surname: "Vasiliev",
			name: "Andrey",
			patronymic: "Sergeevich",
			student_id: 9,
			telegram: "@andrey_vas",
			git: "https://github.com/andrey_vasiliev",
			birthdate: "10.11.2000"),
		tenth_student = Student.new(
			surname: "Novikov",
			name: "Egor",
			patronymic: "Vladimirovich",
			student_id: 10,
			phone_number: "+7(903)-444-55-66",
			email_address: "egor.novikov@gmail.com",
			git: "https://github.com/egor_novikov",
			birthdate: "30.09.1995")
		])
		
		self.data = data_list.get_data
		data_row_count = self.data.row_count
		self.total_pages = (data_row_count.to_f / ROWS_PER_PAGE).ceil
		self.current_page = 1
		
		setup_headers
		update_table
	end
	
	def setup_headers
		headers = self.data_list.get_names
		headers.each_with_index do |header, col_index|
			self.table.setColumnText(col_index, header)
		end
	end
	
	def update_table
		if self.data.nil? || self.data.row_count == 0
			return
		end
		
		clear_table
		
		data_to_display = get_page_data(self.current_page)
		data_to_display.each_with_index do |row, row_index|
			row.each_with_index do |cell, col_index|
				self.table.setItemText(row_index, col_index, cell ? cell.to_s : 'No data')
			end
		end
		
		self.current_page_label.text = "Страница: #{self.current_page}/#{self.total_pages}"
	end
	
	def clear_table
		(0...ROWS_PER_PAGE).each do |row_index|
			(0...self.data.column_count).each do |col_index|
				self.table.setItemText(row_index, col_index, "")
			end
		end
	end
	
	def get_page_data(page_number)
		start_index = (page_number - 1) * ROWS_PER_PAGE
		end_index = start_index + ROWS_PER_PAGE - 1
		data_page = []
		
		(start_index..end_index).each do |row_index|
			if row_index >= self.data.row_count
				break
			end
			row = []
			(0...self.data.column_count).each do |col_index|
				row << self.data.get_element(row_index, col_index)
			end
			data_page << row
		end
		
		return data_page
	end
	
	def switch_page(direction)
		new_page = self.current_page + direction
		if new_page < 1 || new_page > self.total_pages
			return
		end
		self.current_page = new_page
		update_table
	end
	
	def get_selected_rows
		selected_rows = []
		(0...self.table.numRows).each do |row|
			selected_rows << row if self.table.rowSelected?(row)
		end
		return selected_rows
	end
	
	def update_button_states
		selected_rows = get_selected_rows
		
		self.add_button.enabled = true
		self.update_button.enabled = true
		
		case selected_rows.size
		when 0
			self.edit_button.enabled = false
			self.delete_button.enabled = false
		when 1
			self.edit_button.enabled = true
			self.delete_button.enabled = true
		else
			self.edit_button.enabled = false
			self.delete_button.enabled = true
		end
	end
	
	def on_add
	end
	
	def on_update
	end
	
	def on_edit
	end
	
	def on_delete
	end
end