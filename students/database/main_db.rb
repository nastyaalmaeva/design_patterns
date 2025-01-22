require 'pg'
require 'dotenv/load'
require 'date'
require_relative '../student_classes/student.rb'

begin
	connection = PG.connect(
		dbname: ENV['DB_NAME'],
		user: ENV['DB_USER'],
		password: ENV['DB_PASSWORD'],
		host: ENV['DB_HOST'],
		port: ENV['DB_PORT']
	)
	
	puts "Connected to the database successfully!"
	connection.close

rescue PG::Error => e
	puts "An error occurred: #{e.message}"
end