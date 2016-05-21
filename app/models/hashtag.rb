class Hashtag < ActiveRecord::Base
  has_many :hashtag_occurences
  has_many :messages, through: :hashtag_occurences
end
