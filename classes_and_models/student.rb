class Student
	attr_accessor :student_id
	attr_reader :surname, :name, :patronymic, :phone_number, :telegram, :email_address, :git
	
	def initialize(surname:, name:, patronymic:, **options)
		self.student_id = options[:student_id]
		self.surname = surname
		self.name = name
		self.patronymic = patronymic
		self.git = options[:git]
		self.set_contacts(options)
	end
	
	def surname=(value)
		if self.class.valid_format_name?(value)
			@surname = value
		else
			raise ArgumentError, "Wrong surname format. Expected format: English letters (A-Z) or Cyrillic letters (А-Я), optionally hyphenated."
		end
	end
	
	def name=(value)
		if self.class.valid_format_name?(value)
			@name = value
		else
			raise ArgumentError, "Wrong name format. Expected format: English letters (A-Z) or Cyrillic letters (А-Я), optionally hyphenated."
		end
	end
	
	def patronymic=(value)
		if self.class.valid_format_name?(value)
			@patronymic = value
		else
			raise ArgumentError, "Wrong patronymic format. Expected format: English letters (A-Z) or Cyrillic letters (А-Я), optionally hyphenated."
		end
	end
	
	def git=(value)
		if self.class.valid_format_git?(value)
			@git = value
		else
			raise ArgumentError, "Wrong git format. Expected format: http://github.com/username or https://github.com/username."
		end
	end
	
	def git_present?
		!@git.nil?
	end
	
	def contact_present?
		!@phone_number.nil? || !@telegram.nil? || !@email_address.nil?
	end
	
	def validate?
		self.git_present? && self.contact_present?
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
		puts " Validation Status: #{self.validate? ? "Passed" : "Failed"}"
		
		puts "╚══════════════════════════════════════════╝"
	end
	
	private
	
	def self.valid_format_name?(name)
		if name.match(/^[A-Za-z]+(?:-[A-Za-z]+)?$/) || name.match(/^[А-ЯЁа-яё]+(?:-[А-ЯЁа-яё]+)?$/)
			return true
		else
			return false
		end
	end
	
	def self.valid_format_phone_number?(phone_number)
		if phone_number.nil? || phone_number.match(/^\+7\(\d{3}\)-\d{3}-\d{2}-\d{2}$/)
			return true
		else
			return false
		end
	end
	
	def self.valid_format_telegram?(telegram)
		if telegram.nil? || telegram.match(/@[a-zA-Z0-9_]{5,}$/)
			return true
		else
			return false
		end
	end
	
	def self.valid_format_email_address?(email_address)
		if email_address.nil? || email_address.match(/^[\w+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)
			return true
		else
			return false
		end
	end
	
	def self.valid_format_git?(git)
		if git.nil? || git.match(/^https?:\/\/(www\.)?github\.com\/[a-zA-Z0-9_-]+\/?$/)
			return true
		else
			return false
		end
	end
	
	def set_contacts(options)
		if self.class.valid_format_phone_number?(options[:phone_number])
			@phone_number = options[:phone_number]
		else
			raise ArgumentError, "Wrong phone number format. Expected format: +7(XXX)-XXX-XX-XX, where X is a digit."
		end
		
		if self.class.valid_format_telegram?(options[:telegram])
			@telegram = options[:telegram]
		else
			raise ArgumentError, "Wrong telegram format. Expected format: @ followed by 5 or more English alphanumeric characters or underscores."
		end
		
		if self.class.valid_format_email_address?(options[:email_address])
			@email_address = options[:email_address]
		else
			raise ArgumentError, "Wrong email address format. Expected format: name@domain.com."
		end
	end
end
