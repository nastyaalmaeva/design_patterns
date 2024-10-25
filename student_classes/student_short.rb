require_relative 'person.rb'

class StudentShort < Person
	attr_reader :surname_with_initials

	private_class_method :new

	def initialize(surname_with_initials:, student_id: nil, git: nil, contact: nil)
		self.student_id = student_id
		self.surname_with_initials = surname_with_initials
		self.git = git
		set_contacts(contact)
	end
	
	def self.new_from_student_object(student)
		self.new(
			student_id: student.student_id,
			surname_with_initials: student.surname_with_initials,
			git: student.git,
			contact: student.contact
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

	def contact
		return @contact
	end

	def contact_present?
		return !@contact.nil?
	end

	def self.valid_string_format?(input_string)
		pattern = /^Surname and initials: .+ \| Git: .+ \| (Contact|Phone number|Telegram|Email): .+$/
		return input_string.match(pattern) != nil
	end

	def self.valid_format_name?(surname_with_initials)
		if surname_with_initials.match(/^[A-Za-z]/)
			return surname_with_initials.match(/^[A-Za-z][a-z]+(?:[- ][A-Za-z][a-z]+)* \s*([A-Z]\. ?)+$/)
		elsif surname_with_initials.match(/^[А-ЯЁ]/)
			return surname_with_initials.match(/^[А-ЯЁ][а-яё]+(?:[- ][А-ЯЁ][а-яё]+)* \s*([А-ЯЁ]\. ?)+$/)
		else
			return false
		end
	end

	def to_s
		"╔═══════════════════════════════════════════════════╗\n" \
		" Student ID: #{@student_id ? @student_id : 'No data'}\n" \
		" Surname with Initials: #{@surname_with_initials}\n" \
		" Git: #{@git ? @git : 'No data'}\n" \
		" #{get_contact_type(@contact)}: #{@contact ? @contact : 'No data'}\n" \
		"╚═══════════════════════════════════════════════════╝"
	end

	private

	def self.parse_surname_with_initials(input_string)
		surname_with_initials_match = input_string.match(/Surname and initials: ([\w\s\.]+)/)
		if surname_with_initials_match
			return surname_with_initials_match[1].strip
		else
			raise ArgumentError, "Wrong surname with initials format"
		end
	end

	def self.parse_git(input_string)
		git_match = input_string.match(/Git: (https?:\/\/[\w\.\/\-]+|No data)/)
		if git_match[1] == "No data"
			return nil
		elsif git_match
			return git_match[1].strip
		else
			raise ArgumentError, "Wrong git format"
		end
	end

	def self.parse_contact(input_string)
		contact_match = input_string.match(/(?:Contact|Phone number|Telegram|Email): ([^|]+|No data)/)
		if contact_match[1] == "No data"
			return nil
		elsif contact_match
			return contact_match[1].strip
		else
			raise ArgumentError, "Wrong contact format"
		end
	end

	def surname_with_initials=(surname_with_initials)
		if self.class.valid_format_name?(surname_with_initials)
			@surname_with_initials = surname_with_initials
		else
			raise ArgumentError, "Wrong surname with initials format."
		end
	end

	def set_contacts(contact)
		if self.class.valid_format_phone_number?(contact) || self.class.valid_format_telegram?(contact) || self.class.valid_format_email_address?(contact)
			@contact = contact
		else
			raise ArgumentError, "Wrong contact format."
		end
	end
end
