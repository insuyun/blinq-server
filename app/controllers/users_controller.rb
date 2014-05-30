class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show]
	before_action :correct_user, only:[:show]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_path
			# Handle a successful save.
		else
			render 'new'
		end
	end

	def show
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password,
																 :password_confirmation, :student_number)
	end		

	def signed_in_user 
		unless signed_in?
			flash[:warning] = "Please sign in." 
			redirect_to root_url
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
end
