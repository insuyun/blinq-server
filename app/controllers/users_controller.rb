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
