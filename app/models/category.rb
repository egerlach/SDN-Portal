class Category < ActiveRecord::Base
	has_many :topics, :dependent => :destroy
	belongs_to :forum
	
	validates :name, :presence => true
	validates :forum_id, :presence => true
end
