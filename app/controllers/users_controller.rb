class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show]
	before_action :correct_user, only:[:show]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:info] = "Thanks for joining bliq!."
			redirect_to root_path
			# Handle a successful save.
		else
			render 'new'
		end
	end

	def show
		@courses = Course.all
		@user = current_user
	end

	def check
		@user = User.find(params[:id])
		@course = Course.find(params[:course_id])
		if @user.checking?
			@user.stop_check @course
		else
			@user.start_check @course
		end
		
		redirect_to @course
	end

	def union
		@neighbor = User.find_by_attendance_key(params[:attendance_key])
		current_user.union @neighbor if @neighbor
	end

	def token
		if signed_in? and (current_user.push_token != params[:push_token])
			current_user.update_attribute(:push_token, params[:push_token])
		end
	end

	def reset
		Course.all.each do |course|
			lecture = course.lectures.last
			Attendance.destroy_all(lecture_id:lecture.id)
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password,
																 :password_confirmation, :student_number)
	end		

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
end
