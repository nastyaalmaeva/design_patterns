class StudentShort
	attr_reader :surname_with_initials, :git, :contact

	private_class_method :new

	def initialize(surname_with_initials:, student_id: nil, git: nil, contact: nil)
		self.student_id = student_id
		self.surname_with_initials = surname_with_initials
		self.git = git
		self.contact = contact
	end
	
	def self.new_from_student_object(student)
		self.new(
			student_id: student.student_id,
			surname_with_initials: student.get_surname_with_initials,
			contact: student.get_contact_info
		)
	end

	def self.new_from_string(string:, student_id: nil)
		if valid_string_format?(string)
			self.new(
				student_id: student_id,
				surname_with_initials: parse_surname_with_initials(string),
				git: parse_git(string),
				contact: parse_contact(string)
			)
		else
			raise ArgumentError, "String does not match the required format."
		end
	end

	def to_s
		"╔═══════════════════════════════════════════════════╗\n" \
		" Student ID: #{self.student_id ? self.student_id : 'No data'}\n" \
		" Surname with Initials: #{surname_with_initials}\n" \
		" Git: #{self.git ? self.git : 'No data'}\n" \
		" Contact: #{self.contact ? self.contact : 'No data'}\n" \
		"╚═══════════════════════════════════════════════════╝"
	end

	def self.valid_string_format?(string)
		pattern = /^Surname and initials: .+ \| Git: .+ \| Contact: .+$/
		string.match(pattern) != nil
	end

	def self.valid_surname_with_initials?(surname_with_initials)
		if surname_with_initials.match(/^[A-Za-z]/)
			return surname_with_initials.match(/^[A-Za-z][a-z]+(?:[- ][A-Za-z][a-z]+)* \s*([A-Z]\. ?)+$/)
		elsif surname_with_initials.match(/^[А-ЯЁ]/)
			return surname_with_initials.match(/^[А-ЯЁ][а-яё]+(?:[- ][А-ЯЁ][а-яё]+)* \s*([А-ЯЁ]\. ?)+$/)
		else
			return false
		end
	end

	def self.valid_format_phone_number?(phone_number)
		phone_number.nil? || phone_number.match(/^\+7\(\d{3}\)-\d{3}-\d{2}-\d{2} \[phone number\]$/)
	end
  
	def self.valid_format_telegram?(telegram)
		telegram.nil? || telegram.match(/^@[a-zA-Z0-9_]{5,} \[telegram\]$/)
	end
  
	def self.valid_format_email_address?(email)
		email.nil? || email.match(/^[\w+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,} \[email\]$/)
	end

	def self.valid_format_git?(git)
		git.nil? || git.match(/^https?:\/\/(www\.)?github\.com\/[a-zA-Z0-9_-]+\/?$/)
	end

	private

	attr_accessor :student_id

	def surname_with_initials=(surname_with_initials)
		if self.class.valid_surname_with_initials?(surname_with_initials)
			@surname_with_initials = surname_with_initials
		else
			raise ArgumentError, "Wrong surname with initials format."
		end
	end

	def git=(git)
		if self.class.valid_format_git?(git)
			@git = git
		else
			raise ArgumentError, "Wrong git format."
		end
	end

	def contact=(contact)
		if self.class.valid_format_phone_number?(contact) || self.class.valid_format_telegram?(contact) || self.class.valid_format_email_address?(contact)
			@contact = contact
		else
			raise ArgumentError, "Wrong contact format."
		end
	end

	def self.parse_surname_with_initials(string)
		surname_with_initials_match = string.match(/Surname and initials: ([\w\s\.]+)/)
		if surname_with_initials_match
			return surname_with_initials_match[1].strip
		else
			raise ArgumentError, "Wrong string format"
		end
	end

	def self.parse_git(string)
		git_match = string.match(/Git: (https?:\/\/[\w\.\/\-]+|No data)/)
		if git_match[1] == "No data"
			return nil
		elsif git_match
			return git_match[1].strip
		else
			raise ArgumentError, "Wrong string format"
		end
	end

	def self.parse_contact(string)
		contact_match = string.match(/Contact: ([^\[]+\[[^\]]+\]|No data)/)
		if contact_match[1] == "No data"
			return nil
		elsif contact_match
			return contact_match[1].strip
		else
			raise ArgumentError, "Wrong string format"
		end
	end
end
