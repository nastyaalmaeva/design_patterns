def load_array_from_file(file_path)
    begin
        file_content = File.read(file_path).chomp
        cleaned_content = file_content.gsub(";", "").gsub(",", "")
        arr = cleaned_content.split
        for i in 0...arr.length do
            arr[i] = Integer(arr[i])
        end
        return arr
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