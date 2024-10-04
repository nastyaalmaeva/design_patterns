class Student
	attr_accessor :student_id, :surname, :name, :patronymic, :telegram, :email_address, :git
	attr_reader :phone_number

	def initialize(surname:, name:, patronymic:, **options)
		self.student_id = options[:student_id]
		self.surname = surname
		self.name = name
		self.patronymic = patronymic
		self.phone_number = options[:phone_number]
		self.telegram = options[:telegram]
		self.email_address = options[:email_address]
		self.git = options[:git]
	end
	
	def self.valid_format_phone_number?(phone_number)
		if phone_number.nil? || phone_number.match(/^\+7\(\d{3}\)-\d{3}-\d{2}-\d{2}$/)
			return true
		else
			return false
		end
	end
	
	def phone_number=(value)
		if self.class.valid_format_phone_number?(value)
			@phone_number = value
		else
			raise ArgumentError, "Wrong phone number format. Expected format: +7(XXX)-XXX-XX-XX, where X is a digit."
		end
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
