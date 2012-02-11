class Event < ActiveRecord::Base
  belongs_to :user
  has_many :guests
end
