require './student.rb'

first_student = Student.new("Almaeva", "Anastasia", "Ilyinichna", 1, "+7(905)-123-45-67", "@nastya", "nastya@gmail.com", "https://github.com/nastyaalmaeva")
second_student = Student.new("Kuznetsov", "Dmitry", "Nikolaevich", 2, nil, "@dmitry_k", "dmitry.kuznetsov@gmail.com", "https://github.com/dmitry_kuznetsov")
third_student = Student.new("Fedorov", "Maxim", "Olegovich", 3, "+7(925)-888-99-11", "@max_fed", nil, "https://github.com/max_fedorov")

first_student.print_info
second_student.print_info
third_student.print_info
