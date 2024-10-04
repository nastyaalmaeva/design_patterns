class Student
	def initialize(surname, name, patronymic, student_id=nil, phone_number=nil, telegram=nil, email_address=nil, git=nil)
		self.student_id = student_id
		self.surname = surname
		self.name = name
		self.patronymic = patronymic
		self.phone_number = phone_number
		self.telegram = telegram
		self.email_address = email_address
		self.git = git
	end
	
	def student_id
		@student_id
	end
	
	def student_id=(value)
		@student_id = value
	end
	
	def surname
		@surname
	end
	
	def surname=(value)
		@surname = value
	end
	
	def name
		@name
	end
	
	def name=(value)
		@name = value
	end
	
	def patronymic
		@patronymic
	end
	
	def patronymic=(value)
		@patronymic = value
	end
	
	def phone_number
		@phone_number
	end
	
	def phone_number=(value)
		@phone_number = value
	end
	
	def telegram
		@telegram
	end
	
	def telegram=(value)
		@telegram = value
	end
	
	def email_address
		@email_address
	end
	
	def email_address=(value)
		@email_address = value
	end
	
	def git
		@git
	end
	
	def git=(value)
		@git = value
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