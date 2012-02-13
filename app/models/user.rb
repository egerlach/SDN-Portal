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
end
