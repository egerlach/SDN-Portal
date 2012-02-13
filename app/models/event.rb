class Event < ActiveRecord::Base
  belongs_to :user
  has_many :guests
  
  validates :name, :presence => true, :length => { :in => 2..100 }
end
