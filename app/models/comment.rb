class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :newspost
	
	validates :newspost_id, :presence => true
	validates :user_id, :presence => true
	validates :content, :presence => true
end
