module EventsHelper

	# Creates the navigation bar for the events panel
	def event_navigation_bar
		curr_user = current_user
		html = ""
		
		if curr_user
			html << '<ul class="event_nav">'.html_safe
			if @event && @event.id
				html << '<li>'.html_safe
				html << (link_to "Event Info", event_path(@event)).html_safe
				html << '</li><li>'.html_safe
					
				if @event.user_id == curr_user.id || curr_user.admin 
					html << '<li>'.html_safe
					html << (link_to "Edit Event", edit_event_path(@event)).html_safe
					html << '</li><li>'.html_safe
				end
			end
			
			html << '<li>'.html_safe
			html << (link_to "New Event", new_event_path).html_safe
			html << '</li><li>'.html_safe
			
			if curr_user.admin
				html << '<li>'.html_safe
				html << (link_to "Event List", events_path).html_safe
				html << '</li>'.html_safe
			end
			
			html << '</ul>'.html_safe
			
		end
		
		html.html_safe
	end
end
