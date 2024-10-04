require './student.rb'

begin
	first_student = Student.new(
					surname: "Almaeva",
					name: "Anastasia",
					patronymic: "Ilyinichna",
					student_id: 1,
					phone_number: "+7(905)-123-45-67",
					telegram: "@nastya",
					email_address: "nastya@gmail.com",
					git: "https://github.com/nastyaalmaeva")
	second_student = Student.new(
					surname: "Kuznetsov",
					name: "Dmitry",
					patronymic: "Nikolaevich",
					student_id: 2,
					telegram: "@dmitry_k",
					email_address: "dmitry.kuznetsov@gmail.com",
					git: "https://github.com/dmitry_kuznetsov")
	third_student = Student.new(
					surname: "Fedorov",
					name: "Maxim",
					patronymic: "Olegovich",
					student_id: 3,
					phone_number: "+7(925)-888-99-11",
					telegram: "@max_fed",
					git: "https://github.com/max_fedorov")
	fourth_student = Student.new(
					surname: "Ivanov",
					name: "Sergey",
					patronymic: "Viktorovich",
					student_id: 4,
					phone_number: "+7(910)-111-22-33")
	fifth_student = Student.new(
					surname: "Petrov",
					name: "Alexey",
					patronymic: "Dmitrievich",
					student_id: 5)
	
	first_student.print_info
	second_student.print_info
	third_student.print_info
	fourth_student.print_info
	fifth_student.print_info
	
rescue ArgumentError => e
  puts "An error occurred: #{e.message}"
end