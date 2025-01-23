require 'pg'

class DBClient
	def initialize(db_params)
		@db_params = db_params
		@connection = PG.connect(@db_params)
	end
	
	def disconnect
		if not @connection.nil?
			@connection.close
		end
	end

	def execute(query, params = [])
		if connection.nil?
			raise StandardError, 'Database not connected.'
		end
		@connection.exec_params(query, params)
	end
	
	private
	
	attr_reader :connection
end
