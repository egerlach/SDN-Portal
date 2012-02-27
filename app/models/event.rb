class Event < ActiveRecord::Base
  belongs_to :user
  has_many :guests
  
  validates :name, :presence => true, :length => { :in => 2..100 }
  validates :blurb, :presence => true, :length => { :in => 2..200 }
  validates_presence_of :start_at, :end_at, :location
end
