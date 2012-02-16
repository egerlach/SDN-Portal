class User < ActiveRecord::Base
	has_many :projects
	has_many :events
	has_many :comments
	has_many :newsposts
	has_many :topics
	has_many :forumposts
	has_many :achievements
	
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 1..20 }
	validates :userid, :presence => true
	validates :first_name, :presence => true
	validates :email, :presence => true
	validates_format_of :post_colour, :with => /^(([a-fA-F0-9]){3}){1,2}$/
	validates_format_of :font_colour, :with => /^(([a-fA-F0-9]){3}){1,2}$/
end
