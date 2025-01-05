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
	
	file_path = 'students.json'
	json_obj = StudentsListJSON.new(file_path)
	
	array_of_students.each { |student| json_obj.add_student(student) }
	json_obj.write_to_file
	
	puts "\n"
	
	data_list_student_short = json_obj.get_k_n_student_short_list(1, 5)
	
	data_table_student_short = data_list_student_short.get_data
	
	puts "First Page:"
	puts data_table_student_short
	
	puts "\n"
	
	data_list_student_short = json_obj.get_k_n_student_short_list(2, 5, data_list_student_short)
	
	data_table_student_short = data_list_student_short.get_data
	
	puts "Second Page:"
	puts data_table_student_short

rescue => e
	print "An error occurred: #{e.message}"
end
