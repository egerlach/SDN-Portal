class Newspost < ActiveRecord::Base
	has_many :tags
	belongs_to :user
	has_many :comments, :dependent => :destroy
	
	validates :title, :presence => true
	validates :user_id, :presence => true
	validates :content, :presence => true
end
