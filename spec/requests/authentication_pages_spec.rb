require 'spec_helper'

describe "Authentication", :type => :feature do
	subject { page }

	describe "with valid information" do
		before do
			# TODO : change with FactoryGirl
			@user = User.new(student_number: 20080587, 
											 name: "Insu Yun", 
											 email: "wuninsu@gmail.com", 
											 password: "rightpassword",
											 password_confirmation: "rightpassword")
			@user.save

			fill_in 'Email', with: user.email
			fill_in 'Password', with: user.password
			click_button 'Sign in'
		end
	end
end
