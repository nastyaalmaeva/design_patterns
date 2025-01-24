require 'fox16'
require_relative 'view/student_list_view.rb'
require_relative 'controller/student_list_controller.rb'

include Fox

class App < FXMainWindow
    def initialize(app)
        super(app, "Information About Students", width: 1300, height: 800)
        tabs = FXTabBook.new(self, opts: LAYOUT_FILL)
        FXTabItem.new(tabs, "Students")
        student_list = FXVerticalFrame.new(tabs, opts: LAYOUT_FILL)
        student_list_view = StudentListView.new(student_list)
        student_list_view.refresh_data
    end
	
    def create
        super
        show(PLACEMENT_SCREEN)
    end
end
