require_relative '../student_classes/person.rb'
require_relative '../student_classes/student.rb'
require_relative '../student_classes/student_short.rb'
require_relative 'binary_tree.rb'

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
	
	puts "\n"
	
	puts "All Students:"
	puts first_student
	puts second_student
	puts third_student
	puts fourth_student
	puts fifth_student
	
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

rescue => e
	print "An error occurred: #{e.message}"
end