class SessionsController < ApplicationController
	before_action :signed_in_user, only: [:new]

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			if user.admin?
				redirect_to courses_path
			else
				redirect_to user
			end
			# Sign the user in and redirect to the user's show page.
		else
			flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
			render 'new'
		end
	end

	def destroy
		sign_out
		flash[:info] = "Logged out!"
		redirect_to root_path
	end

	private
	def signed_in_user
		if signed_in?
			if current_user.admin?
				redirect_to courses_path
			else
				redirect_to current_user
			end
		end
	end
end
