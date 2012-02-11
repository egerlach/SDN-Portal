
class ApplicationController < ActionController::Base
	protect_from_forgery
  
	# Gets current_user for controller usage
	def current_user
		if session[:cas_user]
			User.find_by_userid(session[:cas_user])
		end
	end
	
	# Checks to see if a user is logged in.
	# Same as user_exists but doesn't redirect on failure. Simply returns false
	def logged_in?
		!!current_user
	end
	
	# user_exists? checks to see if a user has actually been created with session[:cas_user]
	# If the user doesn't exist then they are redirected to the new user page
	def user_exists?
		if User.find_by_userid(session[:cas_user])
			return true
		else
			redirect_to new_user_path
		end
	end
	
	def is_admin?
		curr_user = current_user
		curr_user && curr_user.admin
	end
end
