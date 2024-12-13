require './tag.rb'
require './tree_iterator_dfs.rb'
require './tree_iterator_bfs.rb'

class Tree
	attr_accessor :root

	def initialize(html_string)
		self.root = self.parse_html(html_string)
	end

	def bfs_iterator
		TreeIteratorBFS.new(self.root)
	end

	def dfs_iterator
		TreeIteratorDFS.new(self.root)
	end

	private

	def parse_html(html_string)
		stack = []
		current_parent = nil
		html_string.scan(/<[^>]+>|[^<]+/) do |element|
			element = element.strip
			if element.start_with?("<")
				if opening_element?(element)
					current_parent = process_opening_tag(element, stack, current_parent)
				elsif closing_element?(element)
					process_closing_tag(element, stack)
					current_parent = stack.last
				elsif self_closing_element?(element)
					process_self_closing_tag(element, current_parent)
				end
			elsif not element.empty?
				process_text(element, current_parent)
			end
		end
		return self.root
	end

	def opening_element?(element)
		if element.start_with?('<') and not element.start_with?('</') and not element.end_with?('/>')
			return true
		else
			return false
		end
	end

	def closing_element?(element)
		if element.start_with?('</')
			return true
		else
			return false
		end
	end

	def self_closing_element?(element)
		if element.start_with?('<') and element.end_with?('/>')
			return true
		else
			return false
		end
	end

	def process_opening_tag(element, stack, current_parent)
		tag_content = element[1..-2].strip
		name, string_of_attributes = tag_content.split(" ", 2)
		attributes = Tag.parse_attributes(string_of_attributes)
		tag = Tag.new(name: name, attributes: attributes)
		if not current_parent.nil?
			current_parent.add_child(tag)
		else
			self.root = tag
		end
		stack.push(tag)
		return tag
	end

	def process_closing_tag(element, stack)
		tag_name = element[2..-2].strip
		if not stack.last.nil? and stack.last.name == tag_name
			stack.pop
		end
	end

	def process_self_closing_tag(element, current_parent)
		tag_content = element[1..-3].strip
		name, string_of_attributes = tag_content.split(" ", 2)
		attributes = Tag.parse_attributes(string_of_attributes)
		tag = Tag.new(name: name, attributes: attributes)
		if not current_parent.nil?
			return current_parent.add_child(tag)
		end
	end

	def process_text(element, current_parent)
		if not current_parent.nil?
			current_parent.content += element
		end
	end
end
