require './student.rb'

first_student = Student.new(
				surname: "Almaeva",
				name: "Anastasia",
				patronymic: "Ilyinichna",
				student_id: 1,
				phone_number: "+7(905)-123-45-67",
				telegram: "@nastya",
				email_address: "nastya@gmail.com",
				git: "https://github.com/nastyaalmaeva")
second_student = Student.new(
				surname: "Kuznetsov",
				name: "Dmitry",
				patronymic: "Nikolaevich",
				student_id: 2,
				telegram: "@dmitry_k",
				email_address: "dmitry.kuznetsov@gmail.com",
				git: "https://github.com/dmitry_kuznetsov")
third_student = Student.new(
				surname: "Fedorov",
				name: "Maxim",
				patronymic: "Olegovich",
				student_id: 3,
				phone_number: "+7(925)-888-99-11",
				telegram: "@max_fed",
				git: "https://github.com/max_fedorov")

first_student.print_info
second_student.print_info
third_student.print_info
