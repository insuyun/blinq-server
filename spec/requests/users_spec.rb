require 'spec_helper'

describe "Users", :type => :feature do
	describe "signup" do
		before { visit new_users_path }
		describe "with valid information" do
			let(:submit) { "Sign up" }
			
			before do 
				fill_in 'Email', with: "wuninsu@gmail.com"
				fill_in 'Password', with: "rightpassword"
				fill_in 'Confirmation', with: "rightpassword" 
				fill_in 'Name', with: "Insu Yun"
				fill_in 'Student Number', with: 20080587
			end

			it 'should create a user' do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
end
