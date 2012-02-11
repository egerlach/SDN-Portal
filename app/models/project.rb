class Project < ActiveRecord::Base
	has_many :tags
	has_many :users
	has_one :creator, :class_name => "User"
	
	validates :name, :presence => true
end
