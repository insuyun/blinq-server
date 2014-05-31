module SessionsHelper
	def sign_in(user)
		session[:user_id] = user.id
		current_user= user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		current_user= nil
		session[:user_id] = nil
	end

	def current_user= user
		@current_user= user
	end

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def current_user? user
		@current_user == user
	end

	def signed_in_user 
		unless signed_in?
			flash[:info] = "Please sign in." 
			redirect_to root_url
		end
	end

	def admin_user
		p current_user
		if current_user.admin == false
			puts "admin : false"
		else
			puts "admin : true"
		end

		unless signed_in? and current_user.admin?
			flash[:info] = "Only for administrator."
			redirect_to root_url
		end
	end
end
