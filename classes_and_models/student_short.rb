require_relative 'person.rb'

class StudentShort < Person
	attr_reader :surname_with_initials

	def initialize(option, student_id: nil)
		if option.is_a?(Student)
			self.student_id = option.student_id
			student_info = option.get_info
			parse_and_set_student_info(student_info)
		elsif option.is_a?(String)
			self.student_id = student_id
			parse_and_set_student_info(option)
		else
			raise ArgumentError, "Invalid input type. Must be a Student object or a String."
		end
	end	

	def get_contact
		@contact
	end

	def contact_present?
		!@contact.nil?
	end

	def self.valid_string_format?(input_string)
		pattern = /^Surname and initials: .+ \| Git: .+ \| (Contact|Phone number|Telegram|Email): .+$/
		input_string.match(pattern) != nil
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
		" Contact: #{@contact ? @contact : 'No data'}\n" \
		"╚═══════════════════════════════════════════════════╝"
	end

	private

	def self.parse_surname_with_initials(input)
		surname_with_initials_match = input.match(/Surname and initials: ([\w\s\.]+)/)
		if surname_with_initials_match
			return surname_with_initials_match[1].strip
		else
			raise ArgumentError, "Wrong surname with initials format"
		end
	end

	def self.parse_git(input)
		git_match = input.match(/Git: (https?:\/\/[\w\.\/\-]+|No data)/)
		if git_match[1] == "No data"
			return nil
		elsif git_match
			return git_match[1].strip
		else
			raise ArgumentError, "Wrong git format"
		end
	end

	def self.parse_contact(input)
		contact_match = input.match(/(?:Contact|Phone number|Telegram|Email): ([^|]+|No data)/)
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

	def parse_and_set_student_info(info)
		if self.class.valid_string_format?(info)
			self.surname_with_initials = self.class.parse_surname_with_initials(info)
			self.git = self.class.parse_git(info)
			self.set_contacts(self.class.parse_contact(info))
		else
			raise ArgumentError, "Provided information does not match the required format."
		end
	end
end
