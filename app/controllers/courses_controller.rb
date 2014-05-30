class CoursesController < ApplicationController
	def new
		@course = Course.new
		2.times { @course.schedules.build }
	end

	def create
		@course = Course.new(course_params)
		if @course.save
			flash[:info] = "Successfully created project."
			redirect_to root_url
		else
			render :action => 'new'
		end
	end

	private
	def course_params
		params.require(:course).permit(:name, :code, :instructor, schedules_attributes: [:day, :start_time, :end_time])
	end
end
