require_relative 'student.rb'
require_relative 'student_short.rb'

begin
	first_student = Student.new(
		surname: "Almaeva",
		name: "Anastasia",
		patronymic: "Ilyinichna",
		student_id: 1,
		phone_number: "+7(905)-123-45-67",
		telegram: "@nastya",
		email_address: "nastya@gmail.com",
		git: "https://github.com/nastyaalmaeva"
	)
	second_student = Student.new(
		surname: "Kuznetsov",
		name: "Dmitry",
		patronymic: "Nikolaevich",
		student_id: 2,
		telegram: "@dmitry_k",
		email_address: "dmitry.kuznetsov@gmail.com",
		git: "https://github.com/dmitry_kuznetsov"
	)
	third_student = Student.new(
		surname: "Fedorov",
		name: "Maxim",
		patronymic: "Olegovich",
		student_id: 3,
		phone_number: "+7(925)-888-99-11",
		telegram: "@max_fed",
		git: "https://github.com/max_fedorov"
	)
	fourth_student = Student.new(
		surname: "Ivanov",
		name: "Sergey",
		patronymic: "Viktorovich",
		student_id: 4,
		phone_number: "+7(910)-111-22-33"
	)
	fifth_student = Student.new(
		surname: "Petrov",
		name: "Alexey",
		patronymic: "Dmitrievich",
		student_id: 5
	)
	
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
	second_student_short = StudentShort.new_from_string(student_id: 2, string: "Surname and initials: Ivanov I. I. | Git: https://github.com/ivanovich | Contact: +7(912)-123-45-67 [phone number]")
	third_student_short = StudentShort.new_from_string(student_id: 3, string: "Surname and initials: Petrova P. P. | Git: https://github.com/petrova_p | Contact: @p_petrova [telegram]")
	fourth_student_short = StudentShort.new_from_string(student_id: 4, string: "Surname and initials: Sidorov S. S. | Git: No data | Contact: No data")

	puts first_student_short
	puts second_student_short
	puts third_student_short
	puts fourth_student_short
	
rescue ArgumentError => e
	print "An error occurred: #{e.message}"
end
