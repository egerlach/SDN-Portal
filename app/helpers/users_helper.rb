module UsersHelper

	# Creates the navigation bar for the user panel
	def user_navigation_bar
		curr_user = current_user
		html = ""
		
		html << '<ul class="user_nav">'.html_safe
		
		if @user && curr_user
			html << '<li>'.html_safe
			html << (link_to "User Info", user_path(@user)).html_safe
			html << '</li>'.html_safe
			#html << '<li><a href="/users/self">Forums</a></li><li><a href="/users/self">Projects</a></li>'.html_safe
			if @user == curr_user || curr_user.admin
				html << '<li>'.html_safe
				html << (link_to "Edit Info", edit_user_path(@user)).html_safe
				html << '</li>'.html_safe
				#<li><a href="/users/self">Settings</a></li>
			end
		end
		
		if curr_user && curr_user.admin
			html << '<li>'.html_safe
			html << (link_to "User List", users_path).html_safe
			html << '</li>'.html_safe
		end
		
		html << '</ul>'.html_safe
		
		html.html_safe
	end

	def user_post_styles (user)
		string = 'background-color:#'
		string << user.post_colour
		string << ';color:#'
		string << user.font_colour
		string << ';'
		string
	end
end
