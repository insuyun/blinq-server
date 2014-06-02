class CoursesController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :index, :show]
	before_action :admin_user, only: [:create, :new, :destroy]

	def new
		if current_user.admin?
			@course = Course.new
			2.times { @course.schedules.build }
		else
			@courses = Course.all - current_user.registed_course
		end
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

	def index
		@courses = Course.all
	end

	def destroy
		@course = Course.find(params[:id])
		@course.destroy
		redirect_to courses_url
	end

	def show
			@course = Course.find(params[:id])
	end

	private
	def course_params
		params.require(:course).permit(:name, :code, :instructor, schedules_attributes: [:day, :start_time, :end_time])
	end
end
