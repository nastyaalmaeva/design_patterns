require_relative 'person.rb'
require 'date'

class Student < Person
	include Comparable
	attr_reader :surname, :name, :patronymic, :phone_number, :telegram, :email_address, :birthdate
	
	def initialize(surname:, name:, patronymic:, student_id: nil, phone_number: nil, telegram: nil, email_address: nil, git: nil, birthdate: nil)
		self.student_id = student_id
		self.surname = surname
		self.name = name
		self.patronymic = patronymic
		self.git = git
		self.birthdate = birthdate
		self.set_contacts(phone_number: phone_number, telegram: telegram, email_address: email_address)
	end
	
	def set_contacts(phone_number: nil, telegram: nil, email_address: nil)
		if self.class.valid_format_phone_number?(phone_number)
			@phone_number = phone_number
		else
			raise ArgumentError, "Wrong phone number format. Expected format: +7(XXX)-XXX-XX-XX, where X is a digit."
		end
		
		if self.class.valid_format_telegram?(telegram)
			@telegram = telegram
		else
			raise ArgumentError, "Wrong telegram format. Expected format: @ followed by 5 or more English alphanumeric characters or underscores."
		end
		
		if self.class.valid_format_email_address?(email_address)
			@email_address = email_address
		else
			raise ArgumentError, "Wrong email address format. Expected format: name@domain.com."
		end
	end
	
	def surname_with_initials
		return "#{@surname} #{@name[0].upcase}. #{@patronymic[0].upcase}."
	end

	def contact
		if @phone_number
			return @phone_number
		elsif @telegram
			return @telegram
		elsif @email_address
			return @email_address
		else
			return nil
		end
	end

	def get_info
		"Surname and initials: #{self.surname_with_initials} | " \
		"Git: #{self.git ? self.git : 'No data'} | " \
		"#{get_contact_type(self.contact)}: #{self.contact ? self.contact : 'No data'}"
	end
	
	def to_s
		"╔═══════════════════════════════════════════════════╗\n" \
		" Student ID: #{@student_id ? @student_id : "No data"}\n" \
		" Surname: #{@surname ? @surname : "No data"}\n" \
		" Name: #{@name ? @name : "No data"}\n" \
		" Patronymic: #{@patronymic ? @patronymic : "No data"}\n" \
		" Phone Number: #{@phone_number ? @phone_number : "No data"}\n" \
		" Telegram: #{@telegram ? @telegram : "No data"}\n" \
		" Email Address: #{@email_address ? @email_address : "No data"}\n" \
		" Git: #{@git ? @git : "No data"}\n" \
		" Birthdate: #{@birthdate ? @birthdate : "No data"}\n" \
		" Validation Status: #{self.validate? ? "Passed" : "Failed"}\n" \
		"╚═══════════════════════════════════════════════════╝"
	end
	
	def <=>(other)
		if !other.is_a?(Student)
			return nil
		elsif (self.birthdate.nil? && other.birthdate.nil?) || (self.birthdate.nil?)
			return 1
		elsif other.birthdate.nil?
			return -1
		else
			return self.birthdate <=> other.birthdate
		end
	end
	
	def to_h
		{
			student_id: self.student_id,
			surname: self.surname,
			name: self.name,
			patronymic: self.patronymic,
			phone_number: self.phone_number,
			telegram: self.telegram,
			email_address: self.email_address,
			git: self.git,
			birthdate: self.birthdate&.strftime('%d.%m.%Y')
		}
	end
	
	private
	
	def surname=(surname)
		if self.class.valid_format_name?(surname)
			@surname = surname
		else
			raise ArgumentError, "Wrong surname format. Expected format: English letters (A-Z) or Cyrillic letters (А-Я), optionally hyphenated."
		end
	end
	
	def name=(name)
		if self.class.valid_format_name?(name)
			@name = name
		else
			raise ArgumentError, "Wrong name format. Expected format: English letters (A-Z) or Cyrillic letters (А-Я), optionally hyphenated."
		end
	end
	
	def patronymic=(patronymic)
		if self.class.valid_format_name?(patronymic)
			@patronymic = patronymic
		else
			raise ArgumentError, "Wrong patronymic format. Expected format: English letters (A-Z) or Cyrillic letters (А-Я), optionally hyphenated."
		end
	end
	
	def birthdate=(birthdate)
		if self.class.valid_format_birthdate?(birthdate)
			if not birthdate.nil?
				@birthdate = Date.strptime(birthdate, "%d.%m.%Y")
			else
				@birthdate = nil
			end
		else
			raise ArgumentError, "Wrong birthdate format. Expected format: dd.mm.yyyy."
		end
	end
end
