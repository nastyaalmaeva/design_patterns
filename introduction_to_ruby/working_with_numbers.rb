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

def count_odd_digits_above_three(number)
	odd_digits_count = 0
	while number > 0 do
		digit = number % 10
		if digit > 3 && digit.odd? then
			odd_digits_count += 1
		end
		number /= 10
	end
	return odd_digits_count
end

def digit_sum(number)
	sum_of_digits = 0
	while number > 0 do
		digit = number % 10
		sum_of_digits += digit
		number /= 10
	end
	return sum_of_digits
end

def product_of_divisors_with_digit_sum_less_than(number)
	if number <= 1 then
		return 0
	end
	product_of_divisors = 1
	for divisor in 1..number do
		if number % divisor == 0 && digit_sum(divisor) < digit_sum(number) then
			product_of_divisors *= divisor
		end
	end
	return product_of_divisors
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
		puts "The number of odd digits in #{integer_part} that are greater than 3 is #{count_odd_digits_above_three(integer_part)}."
		puts "The product of the divisors of the number #{integer_part} whose digit sum is less than the sum of the digits of the original number is #{product_of_divisors_with_digit_sum_less_than(integer_part)}."
	else
		puts "\nThe input is not a valid positive integer."
	end
rescue StandardError => e
	puts "\nAn error occurred: #{e.message}"
end