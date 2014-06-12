class RegistrationsController < ApplicationController
	def new
	end

	def register
		@registration = Registration.new
		@registration.course_id = params[:course_id]
		@registration.user_id = current_user.id

		if @registration.save
			flash[:info] = "Successfully registered course."
		else
			flash[:warning] = "Course registration has failed."
		end

		redirect_to user_path(current_user)
	end

	def show
		@registration = Registration.find(params[:id])
		@course = @registration.course
		@user = @registration.user
		@referer = course_path(@course)
	end

	private 
	def registration_params
		params.require(:registration).permit(:course_id)
	end
end
