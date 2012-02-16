class Project < ActiveRecord::Base
	has_many :tags
	has_many :users
	has_one :creator, :class_name => "User"
	
	validates :name, :presence => true, :length => { :in => 2..50 }
	validates :blurb, :length => { :in => 0..100 }
end
