require 'pg'
require 'dotenv/load'
require 'date'
require_relative 'students_list_db.rb'
require_relative '../student_classes/student.rb'
require_relative '../student_classes/student_short.rb'

begin
	connection = PG.connect(
		dbname: ENV['DB_NAME'],
		user: ENV['DB_USER'],
		password: ENV['DB_PASSWORD'],
		host: ENV['DB_HOST'],
		port: ENV['DB_PORT']
	)

	puts "Connected to the database successfully!"

	students_list_db = StudentsListDB.new(connection)

	student = students_list_db.get_student_by_id(10)
	puts "Student with ID 10:"
	puts student

	new_student = Student.new_from_hash({
		surname: 'Ivanov',
		name: 'Ivan',
		patronymic: 'Ivanovich',
		phone_number: '+7(111)-123-12-29',
		telegram: '@ivanov',
		git: 'https://github.com/ivanov',
		email_address: 'ivanov@example.com',
		birthdate: '01.01.2003'
	})
	students_list_db.add_student(new_student)
	puts "New student added."
	
	updated_student = Student.new_from_hash({
		surname: 'Petrov',
		name: 'Petr',
		patronymic: 'Petrovich',
		phone_number: '+7(909)-188-29-29',
		telegram: '@petrov',
		git: 'https://github.com/petrov',
		email_address: 'petrov@example.com',
		birthdate: '04.12.2004'
	})
	students_list_db.replace_student_by_id(20, updated_student)
	puts "Student with ID 20 replaced."
	
	students_list_db.delete_student_by_id(15)
	puts "Student with ID 15 deleted."
	
	page_number = 1
	page_size = 10
	
	student_count = students_list_db.get_student_short_count
	puts "Total number of students: #{student_count}"
	
	connection.close

rescue PG::Error => e
	puts "An error occurred: #{e.message}"
end