class Forum < ActiveRecord::Base
	has_many :categories, :dependent => :destroy
	
	validates :name, :presence => true, :length => { :in => 2..50 }
	validates :description, :presence => true, :length => { :in => 2..100 }
end
