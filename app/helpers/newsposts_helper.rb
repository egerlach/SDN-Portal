module NewspostsHelper

	# Creates the navigation bar for the newsposts panel
	def newspost_navigation_bar
		curr_user = current_user
		html = ""
		
		if curr_user
			html << '<ul class="newspost_nav">'.html_safe
			if @newspost && @newspost.id && (@newspost.user_id == curr_user.id || curr_user.admin)
				html << '<li>'.html_safe
				html << (link_to "Post", newspost_path(@newspost)).html_safe
				html << '</li><li>'.html_safe
					
				html << '<li>'.html_safe
				html << (link_to "Edit Post", edit_newspost_path(@newspost)).html_safe
				html << '</li><li>'.html_safe
			end
			
			if !(request.url.include? "newsposts/new")
				html << '<li>'.html_safe
				html << (link_to "New News", new_newspost_path).html_safe
				html << '</li><li>'.html_safe
			end
				#html << '<li>'.html_safe
				#html << (link_to "Archive", newsposts_path).html_safe
				#html << '</li>'.html_safe
			
			
			html << '</ul>'.html_safe
			
		end
		
		html.html_safe
	end
	
end
