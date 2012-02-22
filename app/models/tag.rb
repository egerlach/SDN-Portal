class Tag < ActiveRecord::Base
	has_and_belongs_to_many :newsposts
	
	validates :name, :presence => true, :length => { :in => 1..25 }
end
