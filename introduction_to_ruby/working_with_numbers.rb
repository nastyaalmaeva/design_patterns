def is_prime?(number)
	if number <= 1 then
		return false
	else
		for divisor in 2...number do
			if number % divisor == 0 then
				return false
			end
		end
	end
	return true
end

def prime_divisor_sum(number)
	if number <= 1 then
		return 0
	end
	sum_of_primes = 0
	for divisor in 2...number do
		if is_prime?(divisor) && number % divisor == 0 then
			sum_of_primes += divisor
		end
	end
	return sum_of_primes
end

begin
	puts "\n"
	print "Enter a number: "
	input_string = gets.chomp
	integer_part = input_string.to_i
	integer_as_string = integer_part.to_s
	if input_string.empty? then
		puts "\nThe input cannot be empty."
	elsif integer_part.to_s == input_string && integer_part > 0 then
		puts "\n"
		puts "The sum of the prime divisors of the number #{integer_part} is #{prime_divisor_sum(integer_part)}."
	else
		puts "\nThe input is not a valid positive integer."
	end
rescue StandardError => e
	puts "\nAn error occurred: #{e.message}"
end