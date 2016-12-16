class Home < ActiveRecord::Base
  has_many :purcahses
  has_many :listings
end