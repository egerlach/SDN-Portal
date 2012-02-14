class Topic < ActiveRecord::Base
	has_many :forumposts, :dependent => :destroy
	has_many :tags
	belongs_to :user
	belongs_to :category
	
	validates :title, :presence => true, :length => { :in => 2..50 }
	validates :user_id, :presence => true
	validates :category_id, :presence => true
end
