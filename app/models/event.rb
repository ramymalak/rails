class Event < ActiveRecord::Base
  belongs_to :group
  has_many :photos
  has_many :comments
  has_many :users , through: :attendees
end
