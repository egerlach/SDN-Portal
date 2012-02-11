class Forum < ActiveRecord::Base
	has_many :categories, :dependent => :destroy
	
	validates :name, :presence => true
end
