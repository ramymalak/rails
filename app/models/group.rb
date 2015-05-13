class Group < ActiveRecord::Base
  belongs_to :country
  belongs_to :city
  belongs_to :user
  has_many :events, dependent: :destroy
end
