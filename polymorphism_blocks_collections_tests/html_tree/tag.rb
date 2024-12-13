class Tag
	attr_reader :name, :attributes, :children, :content
	attr_writer :content

	SELF_CLOSING_TAGS = %w[area base br col embed hr img input link meta param source track wbr].freeze

	def initialize(name:, attributes: {}, children: [], content: "")
		self.name = name
		self.attributes = attributes
		self.children = children
		self.content = content
	end
	
	def opening_tag
		string_of_attributes = self.attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(" ")
		if string_of_attributes.empty?
			if not self.closing?
				return "<#{self.name}>"
			else
				return "<#{self.name}/>"
			end
		else
			if not self.closing?
				return "<#{self.name} #{string_of_attributes}>"
			else
				return "<#{self.name} #{string_of_attributes}/>"
			end
		end
	end

	def closing_tag
		if not self.closing?
			return "</#{self.name}>"
		else
			return ""
		end
	end

	def add_child(child)
		self.children << child
	end

	def self.parse_attributes(string_of_attributes)
		attributes = {}
		string_of_attributes.scan(/([a-zA-Z]+)="([^" >]*)"/) do |key, value|
			attributes[key] = value
		end
		return attributes
	end

	def closing?
		return SELF_CLOSING_TAGS.include?(name)
	end

	private

	attr_writer :name, :attributes, :children
end
