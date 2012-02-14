desc "Setups the inital data for the site"
task :initial_setup => :environment do
	
	Page.create(:name => "About")
	puts "About page created."

	Forum.create(:name => "General Discussion", :description => "General SDN stuff")
	Forum.create(:name => "Projects", :description => "Talk about your projects, entice people, etc.")
	Forum.create(:name => "Off Topic", :description => "Everything Else")
	puts "Basic forums created."

end