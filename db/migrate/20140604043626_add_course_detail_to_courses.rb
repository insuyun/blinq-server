class AddCourseDetailToCourses < ActiveRecord::Migration
  def change
		add_column :courses, :notice, :string
		add_column :courses, :course_type, :int
		add_column :courses, :homepage, :string
		add_column :courses, :career, :int
  end
end
