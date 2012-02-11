require 'sanitize'

module ApplicationHelper
  
	# Returns the header type (that little coloured bar representing the current page)
	def page_type url
	
		if url.include? "users"
			html = "<div class='header_two'></div>"
		elsif url.include? "projects"
			html = "<div class='header_three'></div>"
		elsif (url.include? "forums") || (url.include? "categories") || (url.include? "forumposts") || (url.include? "topics")
			html = "<div class='header_four'></div>"
		elsif url.include? "events"
			html = "<div class='header_five'></div>"
		elsif url.include? "help"
			html = "<div class='header_six'></div>"
		else
			html = "<div class='header_one'></div>"
		end
		
		html.html_safe
	end
	
	# Applies the relaxed sanitize filter on the html
	def safe_content content
		html = "" + content.to_s
		Sanitize.clean(html, Sanitize::Config::RELAXED)
	end
	
	# Applies the basic sanitize filter on the html.
	# Safer than safe_content
	def safer_content content
		html = "" + content.to_s
		Sanitize.clean(html, Sanitize::Config::BASIC)
	end

	# Gets current_user for use in the views
	def current_user
		if session[:cas_user]
			User.find_by_userid(session[:cas_user])
		end
	end
	
	# Returns if the user is logged in for use in the views
	def logged_in?
		!!current_user
	end
	
	# Returns if the user is logged in and an administrator for use in the views
	def is_admin?
		logged_in? && current_user.admin
	end
	
	# Returns the soonest event after today, or the previous one if there is no next one
	def next_event
		next_event = Event.where("start_at >= ?", Date.today).order(:start_at).limit(1).first
		if next_event
			next_event
		else
			Event.where("start_at <= ?", Date.today).order(:start_at).last
		end
	end
end
