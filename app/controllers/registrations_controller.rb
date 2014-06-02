class RegistrationsController < ApplicationController
	def new
	end

	def create
		# Set user id
		@registration = Registration.new(registration_params)
		@registration.user_id = current_user.id

		if @registration.save
			flash[:info] = "Successfully registered course."
		else
			flash[:warning] = "Course registration has failed."
		end

		render :action => 'new'
	end

	private 
	def registration_params
		params.require(:registration).permit(:course_id)
	end
end
