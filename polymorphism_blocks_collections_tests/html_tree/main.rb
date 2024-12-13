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

begin
	html_content = read_html_file_to_string("example.html")
	puts "HTML Content of the file:"
	puts "\n"
	puts html_content
	tree = Tree.new(html_content)
	puts "\n"

	div = Tag.new(
		name: "div",
		attributes: { class: "container" },
		content: "This is a simple example of using the Tag class."
	)
	
	puts "HTML Tag:"
	puts div

rescue => exception
	puts "Error: #{exception.message}"
	exit
end
