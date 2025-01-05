require_relative 'person.rb'
require_relative 'student.rb'
require_relative 'student_short.rb'
require_relative 'binary_tree.rb'
require_relative 'data_table.rb'
require_relative 'data_list.rb'
require_relative 'data_list_student_short.rb'
require_relative 'students_list_json.rb'

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
		student_id: 200,
		telegram: "@dmitry_k",
		email_address: "dmitry.kuznetsov@gmail.com",
		git: "https://github.com/dmitry_kuznetsov",
		birthdate: "01.10.2001")
	third_student = Student.new(
		surname: "Fedorov",
		name: "Maxim",
		patronymic: "Olegovich",
		student_id: 300,
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
	
	puts first_student
	puts second_student
	puts third_student
	puts fourth_student
	puts fifth_student
	
	first_student.set_contacts(phone_number: "+7(888)-777-66-55")
	second_student.set_contacts(email_address: "dmitry_dev@gmail.com")
	third_student.set_contacts(telegram: "@maxim_develop")
	
	puts "\n"
	
	puts "After changing contacts (using get_info):"
	puts first_student.get_info
	puts second_student.get_info
	puts third_student.get_info
	puts fourth_student.get_info
	puts fifth_student.get_info
	
	puts "\n"
	
	first_student_short = StudentShort.new_from_student_object(first_student)
	second_student_short = StudentShort.new_from_string(string: "Surname and initials: Ivanov I. I.  | Git: https://github.com/ivanovich | Phone number: +7(912)-123-45-67", student_id: 2)
	third_student_short = StudentShort.new_from_string(string: "Surname and initials: Petrova P. P.  | Git: https://github.com/petrova_p | Telegram: @p_petrova", student_id: 3)
	fourth_student_short = StudentShort.new_from_string(string: "Surname and initials: Sidorov S. S. | Git: No data                      | Contact: No data", student_id: 4)
	fifth_student_short = StudentShort.new_from_string(string: "Surname and initials: Petrov P. P.  | Git: https://github.com/petrovpp | Phone number: +7(900)-555-55-55", student_id: 5)
	sixth_student_short = StudentShort.new_from_string(string: "Surname and initials: Vasiliev V. V.  | Git: https://github.com/vasilievvv | Telegram: @v_vasiliev", student_id: 6)
	seventh_student_short = StudentShort.new_from_string(string: "Surname and initials: Korolev K. K. | Git: https://github.com/korolevkk | Contact: No data", student_id: 7)
	eighth_student_short = StudentShort.new_from_string(string: "Surname and initials: Novikov N. N. | Git: https://github.com/novikovnn | Phone number: +7(912)-333-44-55", student_id: 8)
	ninth_student_short = StudentShort.new_from_string(string: "Surname and initials: Fedorov F. F.  | Git: https://github.com/fedorovff | Telegram: @fedorovff", student_id: 9)
	tenth_student_short = StudentShort.new_from_string(string: "Surname and initials: Egorov E. E. | Git: No data                      | Contact: No data", student_id: 10)
	
	puts first_student_short
	puts second_student_short
	puts third_student_short
	puts fourth_student_short
	
	# BinaryTree of Students
	array_of_students = [first_student, second_student, third_student, fourth_student, fifth_student]
	age_tree = BinaryTree.new
	
	array_of_students.each { |element| age_tree.insert(element) }
	
	puts "\n"
	
	puts "Sorted Students by Age:"
	iterator = age_tree.iterator
	iterator.each { |data| puts data }
	
	# BinaryTree of Numbers
	array_of_numbers = [1, 11, 34, 12, 45, 5]
	numbers_tree = BinaryTree.new
	
	array_of_numbers.each { |element| numbers_tree.insert(element) }
	
	puts "\n"
	
	puts "Sorted Numbers:"
	iterator = numbers_tree.iterator
	iterator.each { |data| puts data }
	
	puts "\n"
	
	puts "Numbers less than 10:"
	iterator = numbers_tree.iterator
	iterator.select { |number| number < 10 }.each { |data| puts data }
	
	puts "\n\n\n"
	
	# DataListStudentShort Testing
	array_of_short_students = [
		first_student_short,
		second_student_short,
		third_student_short,
		fourth_student_short,
		fifth_student_short,
		sixth_student_short,
		seventh_student_short,
		eighth_student_short,
		ninth_student_short,
		tenth_student_short
	]
	
	data_list_student_short = DataListStudentShort.new(array_of_short_students)
	
	selected_indexes = [0, 1, 2, 5, 7]
	selected_indexes.each { |element| data_list_student_short.select(element) }
	
	puts "Generated DataTable from selected data:"
	data_table_student_short = data_list_student_short.get_data
	puts data_table_student_short
	
	data_list_student_short.clear_selected
	
	# StudentsListJSON Testing
	
	array_of_students = [
		first_student, second_student, third_student, fourth_student, fifth_student,
		sixth_student, seventh_student, eighth_student, ninth_student, tenth_student
	]
	
	puts "\n\n\n"
	
	file_path = 'students.json'
	
	students_list_json = StudentsListJSON.new(file_path)
	array_of_students.each { |student_object| students_list_json.add_student(student_object) } 
	
	students_list_json.write_to_file
	puts "Data successfully written to file!"
	
	data_list_student_short_from_json = students_list_json.get_k_n_student_short_list(1, 3)
	
	data_table_student_short_from_json = data_list_student_short_from_json.get_data
	puts data_table_student_short_from_json
	
	puts "\n\n"
	
	students_list_json.sort_by_surname_with_initials!
	puts students_list_json.get_student_short_count
	
	data_list_sorted_student_short_from_json = students_list_json.get_k_n_student_short_list(1, 3)
	
	sorted_data_table_student_short_from_json = data_list_sorted_student_short_from_json.get_data
	puts sorted_data_table_student_short_from_json

rescue => e
	print "An error occurred: #{e.message}"
end
