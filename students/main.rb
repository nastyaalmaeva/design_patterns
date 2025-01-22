require_relative 'student_classes/person.rb'
require_relative 'student_classes/student.rb'
require_relative 'student_classes/student_short.rb'
require_relative 'data_presentation/data_table.rb'
require_relative 'data_presentation/data_list.rb'
require_relative 'data_presentation/data_list_student_short.rb'
require_relative 'data_strategy/students_list.rb'
require_relative 'data_strategy/json_strategy.rb'
require_relative 'data_strategy/yaml_strategy.rb'

begin
	first_student = Student.new(
		surname: "Almaeva",
		name: "Anastasia",
		patronymic: "Ilyinichna",
		student_id: 1,
		phone_number: "+7(905)-123-45-67",
		telegram: "@nastya",
		email_address: "nastya@gmail.com",
		git: "https://github.com/nastyaalmaeva",
		birthdate: "04.12.2005")
	second_student = Student.new(
		surname: "Kuznetsov",
		name: "Dmitry",
		patronymic: "Nikolaevich",
		student_id: 2,
		telegram: "@dmitry_k",
		email_address: "dmitry.kuznetsov@gmail.com",
		git: "https://github.com/dmitry_kuznetsov",
		birthdate: "01.10.2001")
	third_student = Student.new(
		surname: "Fedorov",
		name: "Maxim",
		patronymic: "Olegovich",
		student_id: 3,
		phone_number: "+7(925)-888-99-11",
		telegram: "@max_fed",
		git: "https://github.com/max_fedorov",
		birthdate: "15.05.1992")
	fourth_student = Student.new(
		surname: "Ivanov",
		name: "Sergey",
		patronymic: "Viktorovich",
		student_id: 4,
		phone_number: "+7(910)-111-22-33",
		birthdate: "15.05.1995")
	fifth_student = Student.new(
		surname: "Petrov",
		name: "Alexey",
		patronymic: "Dmitrievich",
		student_id: 5)
	
	sixth_student = Student.new(
		surname: "Sidorov",
		name: "Nikolay",
		patronymic: "Petrovich",
		student_id: 6,
		phone_number: "+7(901)-222-33-44",
		telegram: "@nikolay_sid",
		email_address: "nikolay.sidorov@gmail.com",
		git: "https://github.com/nikolay_sidorov",
		birthdate: "20.03.1993")
	seventh_student = Student.new(
		surname: "Smirnov",
		name: "Ivan",
		patronymic: "Alexandrovich",
		student_id: 7,
		telegram: "@ivan_smirnov",
		email_address: "ivan.smirnov@gmail.com",
		git: "https://github.com/ivan_smirnov",
		birthdate: "18.07.1998")
	eighth_student = Student.new(
		surname: "Popov",
		name: "Artem",
		patronymic: "Igorevich",
		student_id: 8,
		phone_number: "+7(902)-333-44-55",
		email_address: "artem.popov@gmail.com",
		birthdate: "12.02.1997")
	ninth_student = Student.new(
		surname: "Vasiliev",
		name: "Andrey",
		patronymic: "Sergeevich",
		student_id: 9,
		telegram: "@andrey_vas",
		git: "https://github.com/andrey_vasiliev",
		birthdate: "10.11.2000")
	tenth_student = Student.new(
		surname: "Novikov",
		name: "Egor",
		patronymic: "Vladimirovich",
		student_id: 10,
		phone_number: "+7(903)-444-55-66",
		email_address: "egor.novikov@gmail.com",
		git: "https://github.com/egor_novikov",
		birthdate: "30.09.1995")
	
	array_of_students = [
		first_student, second_student, third_student, fourth_student, fifth_student,
		sixth_student, seventh_student, eighth_student, ninth_student, tenth_student
	]
	
	puts "Choose file format (json/yaml):"
	file_format = gets.chomp.downcase
	file_path = file_format == 'yaml' ? 'students.yaml' : 'students.json'
	
	strategy = file_format == 'yaml' ? YAMLStrategy.new : JSONStrategy.new
	student_list = StudentsList.new(strategy)
	
	current_page = 1
	page_size = 5
	
	loop do
		system('cls') || system('clear')
		puts "Menu:"
		puts "1. View current page"
		puts "2. Go to next page"
		puts "3. Go to previous page"
		puts "4. Jump to specific page"
		puts "5. Change page size"
		puts "6. Save data to file"
		puts "7. Load data from file"
		puts "8. Restore data"
		puts "q. Quit"
		puts "-----------------------------"
		puts "Current page: #{current_page}, Page size: #{page_size}"
		
		case gets.chomp.downcase
		when '1'
			puts "Current Page Data:"
			data_list_student_short = student_list.get_k_n_student_short_list(current_page, page_size)
			data_table_student_short = data_list_student_short.get_data
			puts data_table_student_short
			puts "Press Enter to continue..."
			gets
		when '2'
			current_page += 1
		when '3'
			current_page = [1, current_page - 1].max
		when '4'
			print "Enter page number: "
			current_page = gets.chomp.to_i
		when '5'
			print "Enter new page size: "
			new_page_size = gets.chomp.to_i
			if new_page_size > 0
				page_size = new_page_size
				current_page = 1
				puts "Page size updated to #{page_size}."
			else
				puts "Invalid page size. Please enter a positive number."
			end
			puts "Press Enter to continue..."
			gets
		when '6'
			student_list.write_to_file(file_path)
			puts "Data saved to #{file_path}"
			puts "Press Enter to continue..."
			gets
		when '7'
			student_list.read_from_file(file_path)
			puts "Data loaded from #{file_path}"
			puts "Press Enter to continue..."
			gets
		when '8'
			array_of_students.each { |student| student_list.add_student(student) }
			puts "Data restored from default array."
			puts "Press Enter to continue..."
			gets
		when 'q'
			puts "Exiting..."
			break
		else
			puts "Invalid choice. Please try again."
		end
	end

rescue => e
	print "An error occurred: #{e.message}"
end
