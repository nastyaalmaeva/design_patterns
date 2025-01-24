require 'date'
require 'fox16'
require_relative 'student_list_view'
require_relative 'student_classes/student'
require_relative 'student_classes/student_short'
require_relative 'student_classes/person'

include Fox

application = FXApp.new
main_window = FXMainWindow.new(application, "Information About Students", nil, nil, DECOR_ALL, 0, 0, 1280, 800)
StudentListView.new(main_window)
application.create
main_window.show(PLACEMENT_SCREEN)
  
application.run