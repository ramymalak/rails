class User < ActiveRecord::Base
  belongs_to :country
  belongs_to :city
end