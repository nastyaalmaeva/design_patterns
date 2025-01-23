require 'pg'
require 'dotenv/load'
require 'date'
require_relative 'students_list_db.rb'
require_relative '../student_classes/student.rb'
require_relative '../student_classes/student_short.rb'

begin
	db_client = DBClient.new(
		dbname: ENV['DB_NAME'],
		user: ENV['DB_USER'],
		password: ENV['DB_PASSWORD'],
		host: ENV['DB_HOST'],
		port: ENV['DB_PORT']
	)
	
	students_list_db = StudentsListDB.new(db_client)
	
	puts "Connected to the database successfully!"
	
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
	
	student_count = students_list_db.get_student_short_count
	puts "Total number of students: #{student_count}"
	
	db_client.disconnect

rescue PG::Error => e
	puts "An error occurred: #{e.message}"
end