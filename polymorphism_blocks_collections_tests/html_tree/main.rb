def read_html_file_to_string(file_path)
	begin
		File.open(file_path, "r") do |file|
			html_string = file.read
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

rescue => exception
	puts "Error: #{exception.message}"
	exit
end
