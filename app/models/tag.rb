class Tag < ActiveRecord::Base
	validates :name, :presence => true, :length => { :in => 1..25 }
end
