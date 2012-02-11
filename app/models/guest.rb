class Guest < ActiveRecord::Base
	belongs_to :event
	
	validates :email, :presence => true, :uniqueness => true
	validates :event_id, :presence => true
	validates :first_name, :presence => true
end
