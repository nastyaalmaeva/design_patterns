class Person
	attr_reader :student_id, :git

	def git_present?
		!@git.nil?
	end

	def contact_present?
		!@phone_number.nil? || !@telegram.nil? || !@email_address.nil?
	end
	
	def validate?
		self.git_present? && self.contact_present?
	end

	protected

	def self.valid_student_id?(student_id)
		student_id.nil? || student_id.is_a?(Integer)
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

	def get_contact
		raise NotImplementedError, "Method not implemented in the Person class"
	end
end
