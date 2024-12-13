require "./tag.rb"
require "./tree.rb"

def read_html_file_to_string(file_path)
	begin
		File.open(file_path, "r") do |file|
			html_string = file.read
			if html_string.empty?
				raise "The file is empty"
			end

			return html_string
		end
	rescue => exception
		puts "Error: #{exception.message}"
		exit
	end
end

def print_opening_tags_bfs(tree)
    iterator = tree.bfs_iterator
    iterator.each { |node| puts node.opening_tag }
end

def print_opening_tags_dfs(tree)
    iterator = tree.dfs_iterator
    iterator.each { |node| puts node.opening_tag }
end

def print_elements_with_attributes_bfs(tree)
    iterator = tree.bfs_iterator
    elements_with_attributes = iterator.select { |node| node.attributes && !node.attributes.empty? }
    elements_with_attributes.each { |node| puts node }
end

def print_elements_with_attributes_dfs(tree)
    iterator = tree.dfs_iterator
    elements_with_attributes = iterator.select { |node| node.attributes && !node.attributes.empty? }
    elements_with_attributes.each { |node| puts node }
end


begin
	html_content = read_html_file_to_string("example.html")
	puts "HTML Content of the file:"
	puts html_content

	tree = Tree.new(html_content)

	puts "\n"
	puts "\n"

	puts "BFS:"
	print_opening_tags_bfs(tree)

	puts

	puts "DFS:"
	print_opening_tags_dfs(tree)

	puts "\n"
	puts "\n"

	puts "Tags with attributes (BFS):"
	print_elements_with_attributes_bfs(tree)

	puts

	puts "Tags with attributes (DFS):"
	print_elements_with_attributes_dfs(tree)

rescue => exception
	puts "Error: #{exception.message}"
	exit
end
