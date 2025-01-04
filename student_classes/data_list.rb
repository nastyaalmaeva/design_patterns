class DataList
	attr_reader :data
	
	def initialize(data)
		self.data = data
	end
	
	private
	
	def data=(data)
		if !data.is_a(Array)
			raise ArgumentError, "Data must be an array"
		else
			@data = data.sort
		end
	end
end