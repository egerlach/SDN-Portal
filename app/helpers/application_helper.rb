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
		elsif (url.include? "help") || (url.include? "about")
			html = "<div class='header_six'></div>"
		else
			html = "<div class='header_one'></div>"
		end
		
		html.html_safe
	end
	
	# Applies the relaxed sanitize filter on the html
	def safe_content content
		html = "" + content.to_s
		Sanitize.clean(html, :elements => %w[ul ol br cite code em i p strike strong b a => [href title] img => [alt src title width height] li h1 h2 h3 h4 h5 h6],
		:attributes => {'a' => ['href', 'title'], 'img' => ['alt', 'src', 'title']})
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

	# Gets the gravatar of a user's email if they have one
	def avatar_url(user)
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		"http://gravatar.com/avatar/#{gravatar_id}" + "?s=50" + ".png"
	end
end
