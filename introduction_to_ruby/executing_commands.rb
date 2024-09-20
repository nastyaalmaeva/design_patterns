puts "\n"
print "Enter Ruby command: "
ruby_command_string = gets.chomp
begin
	puts eval(ruby_command_string)
rescue StandardError
	puts "Ruby does not know such a command."
end
print "Enter OS command: "
os_command_string = gets.chomp
system(os_command_string)
