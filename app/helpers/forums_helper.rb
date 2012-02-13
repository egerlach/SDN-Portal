module ForumsHelper
	# Creates the navigation bar for the newsposts panel
	def forum_navigation_bar
		curr_user = current_user
		html = ""
		
		if curr_user
			html << '<ul class="forum_nav">'.html_safe
			
			if @category && @category.id
				html << '<li>'.html_safe
				html << (link_to "Category", category_path(@category)).html_safe
				html << '</li>'.html_safe
					
				html << '<li>'.html_safe
				html << (link_to "Edit Category", edit_category_path(@category, :forum => @forum.id)).html_safe
				html << '</li>'.html_safe
				
				if curr_user.admin
					html << '<li>'.html_safe
					html << (link_to "Del Category", @category, confirm: 'Are you sure?', method: :delete).html_safe
					html << '</li>'.html_safe
				end
			end
			
			if @forum && @forum.id
				html << '<li>'.html_safe
				html << (link_to "Forum", forum_path(@forum)).html_safe
				html << '</li>'.html_safe
					
				if curr_user.admin
					html << '<li>'.html_safe
					html << (link_to "Edit Forum", edit_forum_path(@forum)).html_safe
					html << '</li>'.html_safe
					html << '<li>'.html_safe
					html << (link_to "Delete Forum", @forum, confirm: 'Are you sure?', method: :delete).html_safe
					html << '</li>'.html_safe
				end
			end
			
			if curr_user.admin
				html << '<li>'.html_safe
				html << (link_to "New Forum", new_forum_path).html_safe
				html << '</li>'.html_safe
			end
			
			html << '<li>'.html_safe
			html << (link_to "All Forums", forums_path).html_safe
			html << '</li>'.html_safe
			
			html << '</ul>'.html_safe
			
		end
		
		html.html_safe
	end
end
