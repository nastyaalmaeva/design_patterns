def load_array_from_file(file_path)
    begin
		File.open(file_path, "r") do |file|
			file_content = file.read.chomp
			cleaned_content = file_content.gsub(";", "").gsub(",", "")
			arr = cleaned_content.split
			for i in 0...arr.length do
				arr[i] = Integer(arr[i])
			end
			return arr
		end
    rescue => exception
        puts "Error: #{exception.message}"
        exit
    end
end

def find_min_using_for_in(array)
    min_value = array[0]
    min_pos = 0
    for i in 1...array.length do
        if array[i] < min_value then
            min_value = array[i]
            min_pos = i
        end
    end
    return min_value, min_pos
end

def find_min_using_while_in(array)
    min_value = array[0]
    min_pos = 0
    i = 1
    while i < array.length do
        if array[i] < min_value then
            min_value = array[i]
            min_pos = i
        end
        i += 1
    end
    return min_value, min_pos
end

def find_element_with_for_loop(array, element)
    for i in 0...array.length do
        if array[i] == element then
            return i
        end
    end
    return -1
end

def find_element_with_while_loop(array, element)
    i = 0
    while i < array.length do
        if array[i] == element then
            return i
        end
        i += 1
    end
    return -1
end

def find_first_positive_using_for_in(array)
    for i in 0...array.length do
        if array[i] > 0 then
            return array[i], i
        end
    end
    return -1, -1
end

def find_first_positive_using_while_in(array)
    i = 0
    while i < array.length do
        if array[i] > 0 then
            return array[i], i
        end
        i += 1
    end
    return -1, -1
end

if ARGV.length == 2 then
    action_number = ARGV[0].to_i
    file_path = ARGV[1]
    puts "\n"
    array = load_array_from_file(file_path)
    if array.empty?
        puts "The array is empty, what do you want from me?"
        exit
    end
    case action_number
    when 1
        min_value, min_pos = find_min_using_for_in(array)
        puts "The minimum element found using a for loop is #{min_value}. Index: #{min_pos}."
    when 2
        min_value, min_pos = find_min_using_while_in(array)
        puts "The minimum element found using a while loop is #{min_value}. Index: #{min_pos}."
    when 3
        puts "Enter the element you are looking for: "
        target_value = $stdin.gets.chomp.to_i
        index = find_element_with_for_loop(array, target_value)
        puts index == -1 ? "\nThe element is not in the array." : "The index of the sought element found using a for loop is #{index}."
    when 4
        puts "Enter the element you are looking for: "
        target_value = $stdin.gets.chomp.to_i
        index = find_element_with_while_loop(array, target_value)
        puts index == -1 ? "\nThe element is not in the array." : "The index of the sought element found using a while loop is #{index}."
    when 5
        value, index = find_first_positive_using_for_in(array)
        puts index == -1 ? "\nThere are no positive elements in the array." : "The first positive element found using a for loop is #{value}. Index: #{index}."
    when 6
        value, index = find_first_positive_using_while_in(array)
        puts index == -1 ? "\nThere are no positive elements in the array." : "The first positive element found using a while loop is #{value}. Index: #{index}."
    else
        puts "Invalid action number..."
    end
else
	puts "\n"
    puts "I don't understand what you want!"
	puts "Pass the action number as the first argument, and the path to the array as the second argument."
    puts "\n"
	puts "Actions:"
    puts "1) Find the minimum element of the array using a for loop"
    puts "2) Find the minimum element of the array using a while loop"
    puts "3) Find a specific element of the array using a for loop"
    puts "4) Find a specific element of the array using a while loop"
    puts "5) Find the first positive element of the array using a for loop"
    puts "6) Find the first positive element of the array using a while loop"
end
