require 'pg'
require 'dotenv/load'
require_relative 'students_list_db'
require_relative '../student_classes/student.rb'
require_relative '../student_classes/student_short.rb'
require_relative '../data_presentation/data_list_student_short.rb'

begin
	db_params = {
		dbname: ENV['DB_NAME'],
		user: ENV['DB_USER'],
		password: ENV['DB_PASSWORD'],
		host: ENV['DB_HOST'],
		port: ENV['DB_PORT']
	}
	
	db_client = DBClient.instance(db_params)
	students_db = StudentsListDB.new
	current_page = 1
	page_size = 5
	
	loop do
		system('cls')
		puts "Count Of Students: #{students_db.get_student_short_count}"
		puts "Current page: #{current_page}"
		puts "Current page_size: #{page_size}"
		puts "Students:"
		
		begin
			data_list_student_short = students_db.get_k_n_student_short_list(current_page, page_size)
			data_table_student_short = data_list_student_short.get_data
			puts data_table_student_short
		rescue StandardError => e
			puts "Error fetching students: #{e.message}"
		end
		
		print "Enter your choice (n: next page, p: previous page, a: add student, r: replace student, d: delete student, q: quit): "
		choice = gets.chomp.downcase
		
		case choice
		when 'n'
			current_page += 1
		when 'p'
			if current_page > 1
				current_page -= 1
			end
		when 'a'
			begin
				print "Enter surname: "
				surname = gets.chomp
				print "Enter name: "
				name = gets.chomp
				print "Enter patronymic: "
				patronymic = gets.chomp
				print "Enter phone number (+X(XXX)-XXX-XX-XX): "
				phone_number = gets.chomp
				if phone_number.empty?
					phone_number = nil
				end
				print "Enter telegram (@username): "
				telegram = gets.chomp
				if telegram.empty?
					telegram = nil
				end		
				print "Enter git (https://github/username): "
				git = gets.chomp
				if git.empty?
					git = nil
				end
				print "Enter email address (example@gmail.com): "
				email_address = gets.chomp
				if email_address.empty?
					email_address = nil
				end
				print "Enter birthdate (DD.MM.YYYY): "
				birthdate = gets.chomp
				if birthdate.empty?
					birthdate = nil
				end
				
				new_student = Student.new(
					surname: surname,
					name: name,
					patronymic: patronymic,
					phone_number: phone_number,
					telegram: telegram,
					git: git,
					email_address: email_address,
					birthdate: birthdate
				)
				
				students_db.add_student(new_student)
				puts "Student added successfully!"
			rescue StandardError => e
				puts "Error adding student: #{e.message}"
			end
			puts "Press Enter to continue..."
			gets
		when 'r'
			begin
				print "Enter Student ID: "
				required_id = gets.chomp.to_i
				
				if students_db.get_student_by_id(required_id).nil?
					puts "There is no student with this ID."
				else
					print "Enter new surname: "
					surname = gets.chomp
					print "Enter name: "
					name = gets.chomp
					print "Enter patronymic: "
					patronymic = gets.chomp
					print "Enter phone number (+X(XXX)-XXX-XX-XX): "
					phone_number = gets.chomp
					if phone_number.empty?
						phone_number = nil
					end
					print "Enter telegram (@username): "
					telegram = gets.chomp
					if telegram.empty?
						telegram = nil
					end		
					print "Enter git (https://github/username): "
					git = gets.chomp
					if git.empty?
						git = nil
					end
					print "Enter email address (example@gmail.com): "
					email_address = gets.chomp
					if email_address.empty?
						email_address = nil
					end
					print "Enter birthdate (DD.MM.YYYY): "
					birthdate = gets.chomp
					if birthdate.empty?
						birthdate = nil
					end
					
					new_student = Student.new(
						surname: surname,
						name: name,
						patronymic: patronymic,
						phone_number: phone_number,
						telegram: telegram,
						git: git,
						email_address: email_address,
						birthdate: birthdate
					)
					
					students_db.replace_student_by_id(required_id, new_student)
					puts "Student replaced successfully!"
				end
			rescue StandardError => e
				puts "Error adding student: #{e.message}"
			end
			puts "Press Enter to continue..."
			gets
		when 'd'
			print "Enter Student ID to delete: "
			begin
				student_id = Integer(gets.chomp)
				if students_db.get_student_by_id(student_id).nil?
					puts "There is no student with this ID."
				else
					students_db.delete_student_by_id(student_id)
					puts "Student with ID #{student_id} deleted successfully!"
				end
			rescue ArgumentError
				puts "Invalid ID. Please enter a number."
			rescue StandardError => e
				puts "Error deleting student: #{e.message}"
			end
			puts "Press Enter to continue..."
			gets
		when 'e'
			db_client.disconnect
			puts "Exiting..."
			break
		else
			puts "Invalid choice. Please try again."
		end
	end

rescue StandardError => e
	puts "An error occurred: #{e.message}"
end