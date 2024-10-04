class Student
	attr_accessor :student_id, :surname, :name, :patronymic, :phone_number, :telegram, :email_address, :git

	def initialize(surname:, name:, patronymic:, student_id: nil, phone_number: nil, telegram: nil, email_address: nil, git: nil)
		self.student_id = student_id
		self.surname = surname
		self.name = name
		self.patronymic = patronymic
		self.phone_number = phone_number
		self.telegram = telegram
		self.email_address = email_address
		self.git = git
	end
	
	def print_info
		puts "╔══════════════════════════════════════════╗"
		
		puts " Student ID: #{@student_id ? @student_id : "No data"}"
		puts " Surname: #{@surname ? @surname : "No data"}"
		puts " Name: #{@name ? @name : "No data"}"
		puts " Patronymic: #{@patronymic ? @patronymic : "No data"}"
		puts " Phone Number: #{@phone_number ? @phone_number : "No data"}"
		puts " Telegram: #{@telegram ? @telegram : "No data"}"
		puts " Email Address: #{@email_address ? @email_address : "No data"}"
		puts " Git: #{@git ? @git : "No data"}"
		
		puts "╚══════════════════════════════════════════╝"
	end
end
