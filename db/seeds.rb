# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Page.create(:name => "About")
Forum.create(:name => "General Discussion", :description => "General SDN stuff")
Forum.create(:name => "Projects", :description => "Talk about your projects, entice people, etc.")
Forum.create(:name => "Off Topic", :description => "Everything Else")