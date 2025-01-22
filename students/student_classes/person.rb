class Person
	attr_reader :student_id, :git

	def git_present?
		return !@git.nil?
	end

	def contact_present?
		return !@phone_number.nil? || !@telegram.nil? || !@email_address.nil?
	end
	
	def validate?
		return self.git_present? && self.contact_present?
	end

	def self.valid_student_id?(student_id)
		return student_id.nil? || student_id.is_a?(Integer)
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
	
	def self.valid_format_birthdate?(birthdate)
		if birthdate.nil? || birthdate.match(/^\d{2}\.\d{2}\.\d{4}$/)
			return true
		else
			return false
		end
	end
	
	def get_contact_type(contact)
		if contact.nil?
			return "Contact"
		elsif self.class.valid_format_phone_number?(contact)
			return "Phone number"
		elsif self.class.valid_format_telegram?(contact)
			return "Telegram"
		elsif self.class.valid_format_email_address?(contact)
			return "Email"
		else
			return "Contact"
		end
	end
	
	protected
	
	def student_id=(student_id)
		if self.class.valid_student_id?(student_id)
			@student_id = student_id
		else
			raise ArgumentError, "Wrong student id format."
		end
	end
	
	def git=(git)
		if self.class.valid_format_git?(git)
			@git = git
		else
			raise ArgumentError, "Wrong git format. Expected format: http://github.com/username or https://github.com/username."
		end
	end

	def set_contacts
		raise NotImplementedError, "Method not implemented in the Person class"
	end

	def contact
		raise NotImplementedError, "Method not implemented in the Person class"
	end
	
	def surname_with_initials
		raise NotImplementedError, "Method not implemented in the Person class"
	end
end
