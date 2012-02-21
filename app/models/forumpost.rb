class Forumpost < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
	
	validates :content, :presence => true
	validates :user_id, :presence => true
	validates :topic_id, :presence => true
	validates :post_number, :presence => true
end
