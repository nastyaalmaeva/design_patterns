require "./processing.rb"

def get_array_from_file(file_path)
	begin
		File.open(file_path, "r") do |file|
			file_content = file.read.chomp
			cleaned_content = file_content.gsub(";", "").gsub(",", "")
			string_array = cleaned_content.split
			array = string_array.map { |x| x.to_i }
			return array
		end
	rescue => exception
		puts "Error: #{exception.message}"
		exit
	end
end

def get_array_from_keyboard
	input = gets.chomp
	cleaned_content = input.gsub(";", "").gsub(",", "")
	string_array = cleaned_content.split
	array = string_array.map { |x| x.to_i }
	return array
end

def load_array
	array = []
	puts 'Select the method of loading the array:'
	puts '1. From the keyboard'
	puts '2. From the file'
	loop do
		print "Your choice is: "
		choice = gets.chomp.to_i
		case choice
		when 1
			print "Input your array: "
			array = get_array_from_keyboard
			break
		when 2
			print "Enter the path to the file: "
			file_path = gets.chomp
			array = get_array_from_file(file_path)
			puts "Your array: #{array.join(' ')}"
			break
		else
			puts 'Incorrect choice of loading the array'
		end
	end
	return array
end

def clear_screen
	print "Press Enter to continue... "
	gets
	system('cls')
end

def find_count_of_elements_after_max_element
	array = load_array
	puts "Result: #{Processing.find_count_of_elements_after_max_element(array)}"
end

def main
	loop do
		puts 'Select an action:'
		puts '1. Find the number of elements located after the maximum'
		puts '0. Exit'

		number_of_action = gets.chomp.to_i

		case number_of_action
		when 1
			puts "\n"
			find_count_of_elements_after_max_element
			clear_screen
		when 0
			exit
		else
			puts "\n"
			puts 'Incorrect entry of the action number'
			clear_screen
		end
	end
end

main
