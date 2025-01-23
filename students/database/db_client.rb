require 'pg'

class DBClient
	private_class_method :new
	
	def self.instance(db_params = nil)
		@instance ||= new(db_params)
	end
	
	def initialize(db_params)
		if db_params.nil?
			raise 'Database configuration is required.'
		end
		self.client = PG.connect(db_params)
	end
	
	def disconnect
		if not self.client.nil?
			self.client.close
			self.client = nil
		end
	end
	
	def execute(query, params = [])
		if self.client.nil?
			raise StandardError, 'Database not connected.'
		end
		self.client.exec_params(query, params)
	end
	
	private
	
	attr_accessor :client
	@instance = nil
end