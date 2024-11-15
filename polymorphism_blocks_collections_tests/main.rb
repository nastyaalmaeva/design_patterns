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

def replace_elements_before_min_element
	array = load_array
	puts "Result: #{Processing.replace_elements_before_min_element(array).join(' ')}"
end

def find_max_element_in_interval
	array = load_array
	print "Enter the lower limit of the interval: "
	range_start = gets.chomp.to_i
	print "Enter the upper limit of the interval: "
	range_end = gets.chomp.to_i
	max_element = Processing.find_max_element_in_interval(array, range_start, range_end)
	if max_element.nil?
		puts "There are no elements in this interval"
	else
		puts "Result: #{max_element}"
	end
end

def find_elements_less_than_left_neighbor
	array = load_array
	array_of_indices = Processing.find_elements_less_than_left_neighbor(array)
	puts "Indexes of elements: #{array_of_indices.join(' ')}"
	puts "The number of such elements: #{array_of_indices.size}"
end

def main
	loop do
		puts 'Select an action:'
		puts '1. Find the number of elements located after the maximum'
		puts '2. Place the elements located to the minimum at the end of the array'
		puts '3. Find the maximum of the elements in the interval'
		puts '4. Find the indexes of the elements that are smaller than their left neighbor, and the number of such numbers'
		puts '0. Exit'

		number_of_action = gets.chomp.to_i

		case number_of_action
		when 1
			puts "\n"
			find_count_of_elements_after_max_element
			clear_screen
		when 2
			puts "\n"
			replace_elements_before_min_element
			clear_screen
		when 3
			puts "\n"
			find_max_element_in_interval
			clear_screen
		when 4
			puts "\n"
			find_elements_less_than_left_neighbor
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
