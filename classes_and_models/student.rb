class Student
	attr_accessor :student_id
	attr_reader :surname, :name, :patronymic, :phone_number, :telegram, :email_address, :git

	def initialize(surname:, name:, patronymic:, student_id: nil, phone_number: nil, telegram: nil, email_address: nil, git: nil)
		self.student_id = student_id
		self.surname = surname
		self.name = name
		self.patronymic = patronymic
		self.git = git
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

	def git=(git)
		if self.class.valid_format_git?(git)
			@git = git
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

	def get_surname_with_initials
		"#{surname} #{name[0].upcase}. #{patronymic[0].upcase}."
	end

	def get_git
		git
	end

	def get_contact_info
		if phone_number
			return "#{phone_number} [phone number]"
		elsif telegram
			return "#{telegram} [telegram]"
		elsif email_address
			return "#{email_address} [email address]"
		else
			return nil
		end
	end

	def get_info
		"Surname and initials: #{get_surname_with_initials ? get_surname_with_initials : 'No data'} | " \
		"Git: #{get_git ? get_git : 'No data'} | " \
		"Contact: #{get_contact_info ? get_contact_info : 'No data'}"
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
		" Validation Status: #{self.validate? ? "Passed" : "Failed"}\n" \
		"╚═══════════════════════════════════════════════════╝"
	end

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
end
