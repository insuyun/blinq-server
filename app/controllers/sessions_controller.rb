class SessionsController < ApplicationController
	before_action :signed_in_user, only: [:new]

	def new
		@referer = root_path
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
			# Sign the user in and redirect to the user's show page.
		else
			flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
			render 'new'
		end
	end

	def destroy
		sign_out
		flash[:info] = "Logged Out!"
		redirect_to root_path
	end

	private
	def signed_in_user
		redirect_to current_user if signed_in?
	end
end
