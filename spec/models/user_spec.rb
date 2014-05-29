require 'spec_helper'

describe User, :type => :model do
	before do 
		@user = User.new(student_number: 20080587, 
											name: "Insu Yun", 
											email: "wuninsu@gmail.com", 
											password: "testtest",
											password_confirmation: "testtest")
	end	

	subject { @user }
	it { should be_valid }
end
