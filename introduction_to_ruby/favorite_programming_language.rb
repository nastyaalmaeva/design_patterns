if ARGV.length == 1 then
	puts "\n"
	puts "Hello, #{ARGV[0]}! I'm glad you're ready to take the quiz!"
	print "What is your favourite programming language? "
	language = $stdin.gets.chomp
	puts "\n"
	case language.capitalize
        when 'Ruby'
            puts 'You\'re such a sycophant.'
        when 'Javascript'
            puts 'Bro, 3 + True = 4?'
        when 'Assembler'
            puts 'No comments...'
        when 'C++'
            puts 'I love C++ too, let\'s be friends?'
        when 'C'
            puts 'Only hardcore?'
        else
            puts 'I do not know such a programming language!'
    end
	
	if language.capitalize != 'Ruby'
		puts "Don't worry, Ruby will catch up with you soon!"
	end
else
	print "Hey, didn't they teach you how to say hello? Please pass your name in the first argument..."
end
