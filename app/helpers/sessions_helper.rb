module SessionsHelper
	def sign_in(user)
		session[:user_id] = user.id
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		current_user = nil
		session[:user_id] = nil
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by(session[:user_id]) if session[:user_id]
	end

	def current_user? user
		@current_user == user
	end
end
